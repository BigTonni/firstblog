class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_all_tags, :except => [:create]

  def find_all_tags
    @tags = Tag.all
  end
end
