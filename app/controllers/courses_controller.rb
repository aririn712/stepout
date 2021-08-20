class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show
  def index
    
  end

  def new
    @course = Course.new
  end

  def create
    
  end
end
