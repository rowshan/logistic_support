class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :update, :destroy]

  def sorting_fields
    super + [ :created_at ]
  end

  # GET /schedules
  def index
    @schedules = Schedule.list(sorting_params, pagination_params)

    render json: @schedules
  end

  # GET /schedules/1
  def show
    render json: @schedule
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule, status: :created
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      json_api_params(Schedule, [:date,:driver_id, :shift_id]).fetch(:attributes, {})
    end
end
