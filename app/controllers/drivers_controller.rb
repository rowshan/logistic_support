class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :destroy]

  def sorting_fields
    super + [ :created_at ]
  end

  # GET /drivers
  def index
    @drivers = Driver.list(sorting_params, pagination_params)

    render json: @drivers
  end

  # GET /drivers/1
  def show
    render json: @driver
  end

  # POST /drivers
  def create
    @driver = Driver.new(driver_params)

    if driver_params[:plant_id]
      @driver.plant=Plant.find(driver_params[:plant_id])
    end

    if @driver.save
      render json: @driver, status: :created
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drivers/1
  def destroy
    @driver.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_params
      json_api_params(Driver,[:first_name,:last_name,:phone_no,:plant_id, :user_id,:enabled]).fetch(:attributes, {})
    end
end
