class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    apartment = Apartment.create!(number: params[:number])
    render json: apartment, status: :created
  end

  def index
    apartments = Apartment.all
    render json: apartments, include: [:tenants]
  end

  def show
    apartment = Apartment.find(params[:id])
    render json: apartment
  end

  def update
    apartment = Apartment.find(params[:id])
    apartment.update!(
      number: params[:number]
    )
    render json: apartment
  end

  def destroy
    apartment = Apartment.find(params[:id])
    apartment.destroy
    head :no_content
  end

  private

  def render_unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: :not_found
  end

end
