class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :not_current_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @courses = @user.courses

    orders = Order.where(user_id: current_user.id).pluck(:course_id)
    @order_courses = Course.find(orders)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end

  def not_current_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user.id = @user.id
  end
end
