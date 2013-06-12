class PostsController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :show]
  before_filter :init_tags, :init_posts
  # GET /posts
  # GET /posts.json
  def index
    if params[:tag_name]
      @posts = Post.joins(:tags).where(:tags => {:name => params[:tag_name]})
    end
    #@posts = Post.order("created_at DESC")
    @posts= Post.includes(:user).page(params[:page]).per(4)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.not_hidden.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.tags.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if  current_user.posts.banning_to_approve.length >=3
      respond_to do |format|
        format.html { redirect_to post_path, alert: 'You can create up to 3 posts!'}
      end
    else
      @post = current_user.posts.create(params[:post])
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if current_user.id == @post.user_id && @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  #--------- my methods ---------
  def wait
    @posts = current_user.posts.where("agree = 2 OR agree= 0")
  end

  def count
    count_ban = current_user.posts.banning_to_approve.count
    count_approved = current_user.posts.user_agrees.count
    count_warning = current_user.posts.banning_warning.count
    respond_to do |format|
      format.json { render :json => {:count_ban => count_ban, :count_approved => count_approved, :count_warning => count_warning } }
    end

  end

  private
  def init_tags
    @tags ||= Tag.all
  end

  def init_posts
    @posts ||= Post.not_hidden.user_agrees
  end
end