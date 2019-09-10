# frozen_string_literal: true

# Public: The main controller for displaying the document templates
class DocsController < ApplicationController
  include ApplicationHelper

  FILE = 'index.html.md'

  def index
    md_resource = markdown(index_template_path)
    @md_resource = md_resource
  end

  def change_resource
    md_resource = markdown(change_resource_template_path)
    @md_resource = md_resource
  end

  private

  # Private: Rubocop got upset about line length...
  def rubocop_root_path
    Rails.root.join('templates')
  end

  def index_template_path
    File.read(rubocop_root_path.join(FILE))
  end

  def change_resource_template_path
    File.read(rubocop_root_path.join(params[:resource_id].downcase).join(FILE))
  end
end
