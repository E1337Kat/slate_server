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
    yml_doc = YAML.load_file(@page_content)

    # get a flat list of headers
    headers = []
    yml_doc['production']['resources'].each do |header|
      puts '[INFO] in toc_paged_data'
      resource_name = header[/^[a-zA-Z\-\_\s]+:/]
      resource_name = resource_name.to_s[0..-2]
      @resource_name_lower = resource_name.downcase
      puts "[DEBUG] #{@resource_name_lower}"
      @resource_url = header[%r{\/?[a-zA-Z\-\.\/_]+}]
      puts "[DEBUG} -#{@resource_url}"
      headers.push(id: @resource_name_lower,
                   content: @resource_name_lower,
                   link: @resource_url,
                   level: 1,
                   children: [])
    end

    yml_doc['production'][@resource_name_lower].each do |header_level|
      header_to_nest = nil
      headers = headers.reject do |header|
        if header[:id] == header_level
          header_to_nest[:children].push header if header_to_nest
          true
        else
          header_to_nest = header
          false
        end
      end
    end
    headers
  end
end
