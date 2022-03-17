class CompaniesController < ApplicationController
    
    def index

        @companies = Company.all

        render json: @companies

    end

    def show

        @company = Company.where(["slug = :slug", {slug: params[:slug]}]).first
        
        if (@company)

            # Save @company attributes in a separate object

            company = @company.attributes
            
            @pitch = Pitch.where(["company_id = :company_id", {company_id: @company.id}]).first

            if (@pitch)

                # If @company has an existing @pitch, retrieve the @slides for this @pitch 

                @slides = Slide.where(["pitch_id = :pitch_id", {pitch_id: @pitch.id}])
                
                # Save both @pitch, and @slide in company object 

                pitch = @pitch.attributes
                pitch[:slides] = @slides
                company[:pitch] = pitch

            end
        else
            return render json: {status: "error", message: "No company found for #{params[:slug]}", code: 404}
        end
        
        render json: company

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
