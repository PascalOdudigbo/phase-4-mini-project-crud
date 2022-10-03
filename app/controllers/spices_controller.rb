class SpicesController < ApplicationController
    wrap_parameters format: []
rescue_from ActiveRecord::RecordNotFound, with: :render_no_spices_found

    def index
        spices = Spice.all
        render json: spices
    end

    # def show
    #     spice = find_spice
    #     render json: spice, status: :found
    # end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update 
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :accepted
    end

    def destroy
        spice = find_spice
        spice.destroy
        render json: {}, status: :accepted
    end


    private 
    def find_spice
        Spice.find_by(id: params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_no_spices_found
        render json: {error: "no spices found"}, status: :not_found
    end
end
