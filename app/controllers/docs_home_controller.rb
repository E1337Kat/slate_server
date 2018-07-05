class DocsHomeController < ApplicationController
  include ApplicationHelper
  def index
    @md_resource = markdown(File.read(Rails.root.join('templates').join('index.html.md')))
  end
end
