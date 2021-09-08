class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @courses = @user.courses
    
    orders = Order.where(user_id: current_user.id).pluck(:course_id)
    @order_courses = Course.find(orders)
  end
end

