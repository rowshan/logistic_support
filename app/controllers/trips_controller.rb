class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  def sorting_fields
    super + [ :created_at ]
  end

  # GET /trips
  def index
    @trips = Trip.list(sorting_params, pagination_params)

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

    if @trip.save
      render json: @trip, status: :created
    else
      render json: {errors:@trip.errors}, status: :unprocessable_entity
    end
    #byebug

  end

  # PATCH/PUT /trips/1
  def update

     if trip_params[:trip_kind_id]
       @trip.trip_kind=TripKind.find(trip_params[:trip_kind_id])
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
      json_api_params(Trip,[:trip_kind_id, :order_id, :date, :start_time, :end_time, :address_id]).fetch(:attributes, {})

    end
end
