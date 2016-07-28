class TimeWindowsController < ApplicationController
  before_action :set_time_window, only: [:show, :update, :destroy]
  before_action :validate_tenant, only: [:show, :update, :destroy]


  # GET /time_windows
  def index
    @time_windows = TimeWindow.where(tenant_id: current_context.tenant_id).all

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
      render json: @time_window, status: :created
    else
      render json: @time_window.errors, status: :unprocessable_entity
    end
    #  p time_window_params
  end

  # PATCH/PUT /time_windows/1
  def update

    if @time_window.update(time_window_params)
      render json: @time_window
    else
      render json: @time_window.errors, status: :unprocessable_entity
    end
    #p time_window_params
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

  def validate_tenant
    if @time_window and !@time_window.tenant_id.eql?(current_context.tenant_id)
      raise ApiM8::Exceptions::TenantMismatch.new
    end

    if @time_window and time_window_params.include?(:tenant_id) and !@time_window.tenant_id.eql?(time_window_params[:tenant_id])
      raise ApiM8::Exceptions::TenantMismatch.new
    end
  end

  # Only allow a trusted parameter "white list" through.
  def time_window_params
    json_api_params(TimeWindow, [:tenant_id, :label, :start_time, :end_time]).fetch(:attributes, {})
  end
end
