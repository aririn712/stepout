class CoursesController < ApplicationController
  before_action :authenticate_user!
  def index
    
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
    params.require(:course).permit(:title, :category_id, :text_1, :text_2, :text_3, :text_4, :hour_id, :machine_id, :other_machine, :time_zone_id, :price).merge(user_id: current_user.id)
  end
end
