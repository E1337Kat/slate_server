class CatchAllController < ApplicationController
  def index
    render body: params.inspect
  end
end
