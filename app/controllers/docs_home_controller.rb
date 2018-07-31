class DocsHomeController < ApplicationController
  include ApplicationHelper

  FILE = 'index.html.md'

  def index
    md_resource = markdown(File.read(Rails.root.join('templates').join(FILE)))
    @md_resource = md_resource
  end

  def change_resource
    md_resource = markdown(File.read(Rails.root.join('templates').join(params[:resource_id]).join(FILE)))
    @md_resource = md_resource
  end
end
