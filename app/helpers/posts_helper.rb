module PostsHelper

  def paginate_posts
    paginate(:page => params[:page], per_page: 9)
  end
end
