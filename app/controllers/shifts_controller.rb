class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :update, :destroy]

  def sorting_fields
    super + [ :created_at ]
  end

  # GET /shifts
  def index
    @shifts = Shift.list(sorting_params, pagination_params)

    render json: @shifts
  end

  # GET /shifts/1
  def show
    render json: @shift
  end

  # POST /shifts
  def create
    @shift = Shift.new(shift_params)

    if shift_params[:plant_id]
      @shift.plant=Plant.find(shift_params[:plant_id])
    end

    if @shift.save
      render json: @shift, status: :created
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shifts/1
  def update
     logger.debug 'SHIFT_PARAMS:' + shift_params.inspect

    if @shift.update(shift_params)
      render json: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shifts/1
  def destroy
    @shift.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shift_params
      json_api_params(Shift, [:name,:start_time, :end_time, :send_time, :plant_id,:enabled]
      ).fetch(:attributes, {})
    end
end
