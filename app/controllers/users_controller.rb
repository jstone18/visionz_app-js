class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(:page => params[:page], per_page: 9)

  end

  def show
    @posts = @user.posts.order(created_at: :desc)
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to current_user
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :bio, :image, :password, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Confirms a logged-in user
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Please log in."
      redirect_to user_session_path
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
