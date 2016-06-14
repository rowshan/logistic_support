class TripKindsController < ApplicationController
  before_action :set_trip_kind, only: [:show, :update, :destroy]

  # GET /trip_kinds
  def index
    @trip_kinds = TripKind.all

    render json: @trip_kinds
  end

  # GET /trip_kinds/1
  def show
    render json: @trip_kind
  end

  # POST /trip_kinds
  def create
    @trip_kind = TripKind.new(trip_kind_params)

    if @trip_kind.save
      render json: @trip_kind, status: :created
    else
      render json: @trip_kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trip_kinds/1
  def update
    if @trip_kind.update(trip_kind_params)
      render json: @trip_kind
    else
      render json: @trip_kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trip_kinds/1
  def destroy
    @trip_kind.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_kind
      @trip_kind = TripKind.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_kind_params
      json_api_params(TripKind, [:name,:description]).fetch(:attributes, {})

    end
end
