class AddressesController < ApplicationController
  before_action :set_trip
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /addresses
  def index
    @addresses = Address.where(trip: @trip).all

    render json: @addresses
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    @address.trip = @trip


    if @address.save
      render json: @address, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = @trip.address
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      json_api_params(Address, [:salutation, :first_name, :last_name, :company,
                                :street, :house_no_main, :house_no_add, :other,
                                :postal_code, :postal_code_id, :city, :city_id, :province, :province_id,
                                :country, :country_code, :country_id]).fetch(:attributes, {})

    end
end
