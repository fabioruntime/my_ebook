class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User successfully deleted"
    redirect_to users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

end
