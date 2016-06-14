class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :update, :destroy]

  # GET /shifts
  def index
    @shifts = Shift.all

    render json: @shifts
  end

  # GET /shifts/1
  def show
    render json: @shift
  end

  # POST /shifts
  def create
    @shift = Shift.new(shift_params)
    if shift_params[:time_window_id]
      @shift.time_window=TimeWindow.find(shift_params[:time_window_id])
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
    params_h = shift_params.to_h
    if (params_h.include?(:name))
      @shift=Shift.find(params_h.delete(:name))
    end

    if (params_h.include?(:start_time))
      @shift=Shift.find(params_h.delete(:start_time))
    end

    if (params_h.include?(:end_time))
      @shift=Shift.find(params_h.delete(:end_time))
    end



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
      json_api_params(Shift, [:name,:time_window_id, :start_time, :end_time, :send_time, :enabled]).fetch(:attributes, {})
    end
end
