class PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :update, :destroy]
  before_action :validate_tenant, only: [:show, :update, :destroy]

  # GET /plants
  def index
    @plants = Plant.where(tenant: current_context.tenant_id).all

    render json: @plants
  end

  # GET /plants/1
  def show
    render json: @plant
  end

  # POST /plants
  def create
    @plant = Plant.new(plant_params)

    if @plant.save
      render json: @plant, status: :created
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plants/1
  def update
    if @plant.update(plant_params)
      render json: @plant
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plants/1
  def destroy
    @plant.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_plant
    @plant = Plant.find(params[:id])
  end

  def validate_tenant
    if @plant and !@plant.tenant_id.eql?(current_context.tenant_id)
      raise ApiM8::Exceptions::TenantMismatch.new
    end

    if @plant and plant_params.include?(:tenant_id) and !@plant.tenant_id.eql?(plant_params[:tenant_id])
      raise ApiM8::Exceptions::TenantMismatch.new
    end
  end

  # Only allow a trusted parameter "white list" through.
  def plant_params
    json_api_params(Plant, [:company, :email, :phone_no, :address, :tenant_id]).fetch(:attributes, {})
  end
end
