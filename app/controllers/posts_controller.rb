class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts.paginate(:page => params[:page], per_page: 9)
    else
      @posts = Post.recent.paginate(:page => params[:page], per_page: 9)
    end
  end

  def show
    @comments = Comment.where(post_id: @post)
    # if @post.user != @user
    if params[:user_id].to_i != @post.user_id
      redirect_to posts_path
    end
  end

  def new
     @post = Post.new(user_id: params[:user_id])
  end

  def create
    # user_id column will be generated when a post is created
    @post = current_user.posts.build(post_params)

    if @post.save

      redirect_to user_post_path(@post.user, @post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(@post.user, @post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @post.downvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :description, :image, :user_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
