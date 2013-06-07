class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.json { render json: @tags }
    end
  end
end
