class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
		@post = Post.find(params[:post_id])
		@comments = Comment.all
		@post_comments = @post.comments
    render :json => @post_comments
	end

  def show
    @comment = Comment.new
    @comment.post_id = @post.id
    @post_comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      render json: @comment, status: 201
    else
      render 'post/show'
    end
  end

end
