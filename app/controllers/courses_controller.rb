class CoursesController < ApplicationController
  before_action :authenticate_user!
  def index
    @courses = Course.all.order('created_at DESC')
    @course1 = Course.where(category_id: 2)
    @course2 = Course.where(category_id: 3)
    @course3 = Course.where(category_id: 4)
    @course4 = Course.where(category_id: 5)
    @course5 = Course.where(category_id: 6)
    @course6 = Course.where(category_id: 7)
    @course7 = Course.where(category_id: 8)
    @course8 = Course.where(category_id: 9)
    @course9 = Course.where(category_id: 10)
    @course10 = Course.where(category_id: 11)

  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :category_id, :text_1, :text_2, :text_3, :text_4, :hour_id, :machine_id, :other_machine, :time_zone_id, :price, :image).merge(user_id: current_user.id)
  end
end
