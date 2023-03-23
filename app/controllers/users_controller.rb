class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    ebooks = user.ebooks
    render :show, locals: { user: user, ebooks: ebooks }
  end

  def index
    users = User.all
    render :index, locals: { users: users }
  end

  def new
    render :new, locals: { user: User.new }
  end

  def edit
    user = User.find(params[:id])
    render :edit, locals: { user: user }
  end

  def create
    user = User.new(user_params)
    user.save!
    redirect_to users_path, notice:"User created successfully"

  rescue StandardError => e
    flash[:danger] = "Error creating a new User: #{e} "
    old_input = params
    render :new, locals: { user: nil, params: old_input }, status: :unprocessable_entity
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    redirect_to user, notice: "User updated successfully."

  rescue StandardError => e
    flash[:danger] = "Error to update: #{e} "
    old_input = params
    render :edit, locals: { user: nil, params: old_input }, status: :unprocessable_entity
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, status: :see_other, notice: "User deleted successfully"
  end

  def manager_users
    render :manager_ebooks, locals: { users: User.all }
  end

  def change_status
    if params[:status].present? && User::statuses.include?(params[:status].to_sym)
      user = User.find(params[:id])
      user.update(status: params[:status])
      redirect_to @user, notice: "Status updated to #{@user.status}"
    else
      render :manager_users, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :status, :avatar)
  end

end
