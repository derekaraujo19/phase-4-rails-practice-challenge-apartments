class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def index
    tenants = Tenant.all
    render json: tenants, include: [:apartments]
  end

  def show
    tenant = Tenant.find(params[:id])
    render json: tenant
  end

  def update
    tenant = Tenant.find(params[:id])
    tenant.update!(tenant_params)
    render json: tenant
  end

  def destroy
    tenant = Tenant.find(params[:id])
    tenant.destroy
    head :no_content
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def render_unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {error: "Tenant not found"}, status: :not_found
  end

end
