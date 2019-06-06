module UsersHelper

  def profile_pic
    if @user.avatar.exists?
      image_tag @user.avatar.url, class: "avatar"
    else
      image_tag("avatar_png_71508", class: "avatar")
    end
  end

  def edit_profile
    if @user == current_user
      link_to "Edit Profile", edit_user_path(@user), class: "edit-profile button"
    end
  end

end
