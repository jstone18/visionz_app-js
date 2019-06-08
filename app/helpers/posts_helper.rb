module PostsHelper

  def paginate_posts
    paginate(:page => params[:page], per_page: 9)
  end

  def edit_post
    if @post.user == current_user
      link_to "Edit", edit_post_path(@post), class: "data"
    end
  end

  def delete_post
    if @post.user == current_user
      link_to "Delete", post_path(@post), method: :delete, data: { confirm: 'Are you sure?' }, class: "data"
    end
  end

  def posted_at
    time_ago_in_words(@post.created_at)
  end

end
