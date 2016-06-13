class TimeWindowsController < ApplicationController
  before_action :set_time_window, only: [:show, :update, :destroy]

  # GET /time_windows
  def index
    @time_windows = TimeWindow.all

    render json: @time_windows
  end

  # GET /time_windows/1
  def show
    render json: @time_window
  end

  # POST /time_windows
  def create
    @time_window = TimeWindow.new(time_window_params)

    if @time_window.save
      render json: @time_window, status: :created, location: @time_window
    else
      render json: @time_window.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_windows/1
  def update
    if @time_window.update(time_window_params)
      render json: @time_window
    else
      render json: @time_window.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_windows/1
  def destroy
    @time_window.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_window
      @time_window = TimeWindow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_window_params
      params.fetch(:time_window, {})
    end
end
