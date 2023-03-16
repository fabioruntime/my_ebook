class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_status]

  def show
    @ebooks = @user.ebooks
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def manager_users
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User successfully deleted"
    redirect_to users_path, status: :see_other
  end

  def change_status
    if params[:status].present? && User::statuses.include?(params[:status].to_sym)
      @user.update(status: params[:status])
      redirect_to @user, notice: "Status updated to #{@user.status}"
    else
      render :manager_users, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :status)
  end

end
