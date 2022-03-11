class CompaniesController < ApplicationController
    
    def index
        @companies = Company.all

        render json: @companies
    end

    def show
        @company = Company.where(["slug = :slug", {slug: params[:slug]}]).first

        render json: @company
    end

    def create
        @company = Company.create(name: params[:name], description: params[:description])

        render json: @company
    end

    def update
        @company = Company.where(["slug = :slug", {slug: params[:slug]}]).first
        @company.update(name: params[:name], description: params[:description])

        render json: "#{@company.name} has been updated"
    end

    def destroy
        @company = Company.where(["slug = :slug", {slug: params[:slug]}]).first
        @company.destroy

        render json: "#{@company.name} has been deleted"
    end
    
end
