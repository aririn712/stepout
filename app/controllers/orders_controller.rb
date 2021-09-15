class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :favorite]
  before_action :not_seller, only: [:create, :destroy]
  before_action :not_order, only: :favorite

  def create
    course = Course.find(params[:course_id])
    current_user.like(course)
    redirect_back fallback_location: root_path, success: '申請しました'
  end

  def destroy
    course = current_user.orders.find_by(params[:id]).course
    current_user.unlike(course)
    redirect_back fallback_location: root_path, success: '申請を取り消しました'
  end

  def favorite
    @course = Course.find(params[:course_id])
    order_course = Order.where(course_id: @course.id)
    orders = order_course.pluck(:user_id)
    @order_users = User.find(orders)
  end

  private

  def not_seller
    course = Course.find(params[:course_id])
    redirect_to root_path if current_user.id == course.user_id
  end

  def not_order
    course = Course.find(params[:course_id])
    redirect_to root_path unless current_user.id == course.user_id
  end
end
