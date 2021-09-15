class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @courses = Course.all.order('created_at DESC')
    @course1 = Course.where(category_id: 2).order('created_at DESC')
    @course2 = Course.where(category_id: 3).order('created_at DESC')
    @course3 = Course.where(category_id: 4).order('created_at DESC')
    @course4 = Course.where(category_id: 5).order('created_at DESC')
    @course5 = Course.where(category_id: 6).order('created_at DESC')
    @course6 = Course.where(category_id: 7).order('created_at DESC')
    @course7 = Course.where(category_id: 8).order('created_at DESC')
    @course8 = Course.where(category_id: 9).order('created_at DESC')
    @course9 = Course.where(category_id: 10).order('created_at DESC')
    @course10 = Course.where(category_id: 11).order('created_at DESC')
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to "/users/#{current_user.id}"
    else
      render :new
    end
  end

  def show
    @order = Order.find_by(user_id: current_user.id, course_id: @course.id)
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course.id)
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to "/users/#{current_user.id}"
  end
  
  def search
    @courses = Course.search(params[:keyword])
  end

  private

  def course_params
    params.require(:course).permit(:title, :category_id, :text_1, :text_2, :text_3, :text_4, :hour_id, :machine_id,
                                   :other_machine, :time_zone_id, :price, :image).merge(user_id: current_user.id)
  end

  def find_params
    @course = Course.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @course.user_id
  end

end
