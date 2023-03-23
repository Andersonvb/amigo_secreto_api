class V1::LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  def index
    @locations = Location.order(:id)
  end

  def show; end

  def create
    @location = Location.new(location_params)

    if @location.save
      render @location
    else
      render 'errors/error', locals: { object: @location }, formats: :json
    end
  end

  def update
    if @location.update(location_params)
      render :create, status: :created
    else
      render 'errors/error', locals: { object: @location }, formats: :json
    end
  end

  def destroy
    @location.destroy
    head :no_content
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
