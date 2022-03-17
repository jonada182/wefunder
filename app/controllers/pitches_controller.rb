class PitchesController < ApplicationController
    
    def index

        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first

        if (@company)

            @pitch = Pitch.where(["company_id = :company_id", {company_id: @company.id}]).first
            
            if (@pitch)
                @slides = Slide.where(["pitch_id = :pitch_id", {pitch_id: @pitch.id}])
            else
                return render json: {status: "error", message: "No pitch found for #{params[:company_slug]}", code: 404}
            end
            
        else
            return render json: {status: "error", message: "No company found for #{params[:company_slug]}", code: 404}
        end

        # Save @pitch attributes in separate object, and include the pitch @slides 

        pitch = @pitch.attributes

        pitch[:slides] = @slides

        render json: pitch

    end

    def show

        @pitch = Pitch.find(params[:id])

        render json: @pitch

    end

    def create

        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first
        
        if (@company)
            
            @pitch = Pitch.where(["company_id = :company_id", {company_id: @company.id}]).first

            # Update existing @pitch, or create a new one 
            
            if (@pitch)
                @pitch.update(name: params[:name], company_id: @company.id)
            else
                @pitch = Pitch.create(name: params[:name], company_id: @company.id)
            end

        else
            return render json: {status: "error", message: "No company found for #{params[:company_slug]}", code: 404}
        end

        render json: @pitch

    end

    def update

        @company = Company.where(["slug = :slug", {slug: params[:company_slug]}]).first
        
        if (@company)

            @pitch = Pitch.find(params[:id])
            @pitch.update(name: params[:name], company_id: @company.id)

        else
            return render json: {status: "error", message: "No company found for #{params[:company_slug]}", code: 404}
        end

        render json: "#{@pitch.name} has been updated"
    
    end

    def destroy

        @pitch = Pitch.find(params[:id])
        @pitch.destroy

        render json: "#{@pitch.name} has been deleted"
    
    end
    
end
