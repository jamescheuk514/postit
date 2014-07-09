class SessionsController < ApplicationController

  def new
  end

  def create
    user =  User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You've logged in!"
      redirect_to root_path
    else
      flash[:danger] = "wrong username or password!"
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've logged out!"
    redirect_to root_path
  end
end
