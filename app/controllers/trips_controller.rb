class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index
    @trips = Trip.all

    render json: @trips
  end

  # GET /trips/1
  def show
    render json: @trip
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)
    if trip_params[:trip_kind_id]
      @trip.trip_kind = TripKind.find(trip_params[:trip_kind_id])
    end
    if trip_params[:time_window_id]
      @trip.time_window = TimeWindow.find(trip_params[:time_window_id])
    end

    if @trip.save
      render json: @trip, status: :created
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
    byebug

  end

  # PATCH/PUT /trips/1
  def update
     if trip_params[:trip_kind_id]
       @trip.trip_kind=TripKind.find(trip_params[:trip_kind_id])
     end

     if trip_params[:time_window_id]
       @trip.time_window = TimeWindow.find(trip_params[:time_window_id])
     end

     if @trip.update(trip_params)
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_params
      json_api_params(Trip,[:trip_kind_id, :order_id, :date, :time_window_id, :address_id]).fetch(:attributes, {})

    end
end
