class V1::WorkersController < ApplicationController
  def index
    @workers = Worker.all
  end

  def show
    @worker = Worker.find(params[:id])
  end

  def create
    @worker = Worker.new(worker_params)

    if @worker.save
      render @worker
    else
      render 'errors/error', locals: { object: @worker }, formats: :json
    end
  end

  def update
    @worker = Worker.find(params[:id])

    if @worker.update(worker_params)
      render @worker
    else
      render 'errors/error', locals: { object: @worker }, formats: :json
    end
  end

  private

  def worker_params
    params.require(:worker).permit(:name, :location_id)
  end
end
