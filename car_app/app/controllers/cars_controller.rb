class CarsController < ApplicationController

  def index
    @cars = Car.all
  end

  def new
     @car = Car.new
  end

  def create
    car_params
    @car = Car.new(car_params)

    if @car.save
      flash[:notice] = "Car Successfully Added"
      redirect_to cars_path
    else
      render :new
    end

  end

  private

  def car_params
    params.require(:car).permit(:manufacturer_id, :color, :year, :mileage)
  end

end
