class OrdersController < ApplicationController
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
end