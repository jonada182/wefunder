class PitchesController < ApplicationController
    
    def index
        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first
        @pitches = Pitch.where(["company_id = :company_id", {company_id: @company.id}])

        render json: @pitches
    end

    def show
        @pitch = Pitch.find(params[:id])

        render json: @pitch
    end

    def create
        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first
        @pitch = Pitch.create(name: params[:name], company_id: @company.id)

        render json: @pitch
    end

    def update
        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first
        @pitch = Pitch.find(params[:id])
        @pitch.update(name: params[:name], company_id: @company.id)

        render json: "#{@pitch.name} has been updated"
    end

    def destroy
        @pitch = Pitch.find(params[:id])
        @pitch.destroy

        render json: "#{@pitch.name} has been deleted"
    end
    
end
