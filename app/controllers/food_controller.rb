class FoodController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to food_index_path
    else
      render :new, notice: 'Please try again'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.user_id == current_user.id
      @food.destroy
      redirect_to request.referer, notice: 'Food deleted successfully'
    else
      redirect_to request.referer, notice: 'You are not authorized to delete this food'
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price, :other_attributes)
  end
end
