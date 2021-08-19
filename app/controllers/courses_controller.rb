class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:index,:new, :create, :edit, :update, :destroy]
  def index
    
  end
end
