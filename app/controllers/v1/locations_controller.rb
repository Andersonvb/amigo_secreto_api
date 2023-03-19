class V1::LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      render @location
    else
      render 'errors/error', locals: { object: @location }, formats: :json
    end
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
