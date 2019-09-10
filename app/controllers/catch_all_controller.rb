# frozen_string_literal: true

# Public: Controller for catching any bad routes.
class CatchAllController < ApplicationController
  include ApplicationHelper

  def index; end
end
