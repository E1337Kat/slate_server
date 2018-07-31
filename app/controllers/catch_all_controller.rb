# Public: Controller for catching any bad routes.
class CatchAllController < ApplicationController
  include ApplicationHelper

  def index; end
end
