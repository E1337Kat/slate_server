# frozen_string_literal: true

require 'yaml'
# Public: A method of grabbing and storing the table of contents headers
# from config/data.yml
#
# Example
#
#   toc_paged_helper = TocPagedData.new('config/data.yml')
#   toc_paged_data = toc_paged_helper.toc_paged_data
#   ...
#   toc_paged_data.each do |h1|
#     h1[:children].each do |request|
#     ...
#     end
#   end
class TocPagedData

  def initialize(content)
    @page_content = content
  end

  def toc_paged_data
    @yml_doc = YAML.load_file(@page_content)

    # get a flat list of headers
    @headers = []
    @yml_doc['production']['resources'].each do |header|
      Rails.logger.info '[toc_paged_data]In toc_paged_data...'
      resource_name = header[/^[a-zA-Z\-\_\s]+:/]
      resource_name = resource_name.to_s[0..-2]
      @resource_name_lower = resource_name.downcase
      Rails.logger.debug "[toc_paged_data]Found resource_name_lower to be: #{@resource_name_lower}"
      @resource_url = header[%r{\/?[a-zA-Z\-\.\/_]+}]
      Rails.logger.debug "[toc_paged_data]Found resource_url to be: #{@resource_url}"
      @headers.push(id: @resource_name_lower,
                    content: resource_name,
                    link: @resource_url,
                    level: 1,
                    children: [])
      process_children
    end
    @headers
  end

  def process_children
    @yml_doc['production'][@resource_name_lower].each do |child_header|
      Rails.logger.debug '[toc_paged_data]Processing TOC data children...'
      Rails.logger.debug "[toc_paged_data]Current child is: #{child_header}"
      request_name = child_header[/^([0-9]+\))?[0-9a-zA-Z\-\_\s]+:/]
      request_name = request_name.to_s[0..-2]
      Rails.logger.debug "[toc_paged_data]Found request_name to be: #{request_name.to_s}"
      request_fragment = child_header[/:'([0-9]+\))?[0-9a-zA-Z\-\_\(\)#&;]+'/]
      request_fragment = request_fragment.to_s[2..-2]
      request_fragment = sanitize(request_fragment)
      Rails.logger.debug "[toc_paged_data]Found request_fragment to be: #{request_fragment.to_s}"
      @headers.each do |header|
        # Check whether this is the current header or not.
        if header[:id] == @resource_name_lower
          Rails.logger.debug "[toc_paged_data]Current header (#{header[:id].to_s}) is equal to current resource (#{@resource_name_lower})."
          header[:children].push(id: request_name,
                                 content: request_name,
                                 link: request_fragment,
                                 level: 2,
                                 children: [])
        end
      end
    end
  end

  def sanitize(string)
    string.tr(')', '').tr('(', '').tr('_', '-').tr('\'','')
  end
end
