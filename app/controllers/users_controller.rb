class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    if @user.save == true
      # redirect
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    # @user.update_attribute(user_params)
  end

  def destroy
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
