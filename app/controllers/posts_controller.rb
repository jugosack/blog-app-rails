class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :select_user, only: %i[index show destroy]
  before_action :set_post, only: %i[show destroy]

  # GET /posts or /posts.json
  def index
    # select_user
    @posts = @user.posts.includes(:comments)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    post = Post.new(post_params)
    post.author = current_user
    respond_to do |format|
      if post.save
        format.html { redirect_to "/users/#{current_user.id}", notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to "/users/#{current_user.id}", notice: 'Post was not successfully created.' }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # select_user
    # # set_post
    # @comments = @post.comments.includes(:author)
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # select_user
    # set_post
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'Post deleted'
    else
      redirect_to user_posts_path(current_user), alert: 'Post not deleted'
    end
  end

  private

  def select_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
