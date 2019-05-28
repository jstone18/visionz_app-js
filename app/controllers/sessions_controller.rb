class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      oauth_email = request.env["omniauth.auth"]["info"]["email"]
      oauth_name = request.env["omniauth.auth"]["info"]["name"]

      if @user = User.find_by(email: oauth_email)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        @user = User.new(name: oauth_name, email: oauth_email, password: SecureRandom.hex)
        if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          raise @user.errors.full_messages.inspect
        end
      end
    else
      #  Normal Login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to login_path
      end
    end
  end

  def destroy
  end
end
