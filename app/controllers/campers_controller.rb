class CampersController < ApplicationController
 
    rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found
    
    def index
        render json: Camper.all, include: [], status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, status: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def camper_not_found
        render json: { "error": "Camper not found" }, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end
end
