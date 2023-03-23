class V1::WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :update, :destroy]

  def index
    @workers = Worker.order(:id)
  end

  def show; end

  def create
    @worker = Worker.new(worker_params)

    if @worker.save
      render @worker
    else
      render 'errors/error', locals: { object: @worker }, formats: :json
    end
  end

  def update
    if @worker.update(worker_params)
      render :create, status: :created
    else
      render 'errors/error', locals: { object: @worker }, formats: :json
    end
  end

  def destroy
    @worker.destroy
    head :no_content
  end

  private

  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:name, :location_id)
  end
end
