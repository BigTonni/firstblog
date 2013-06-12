class TagsController < ApplicationController

  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def new
    @tags = Tag.new
    @tags.tags.build
  end

  def create
    @tags = Tag.new(params[:name])
    respond_to do |format|
      if @tags.save
        format.html { redirect_to @tags, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tags }
      else
        format.html { render action: 'new' }
        format.json { render json: @tags.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @posts = Tag.find(params[:tag_id]).posts
    respond_to do |format|
      format.html # tag.html.erb
      format.json { render json: @posts }
    end
  end

end