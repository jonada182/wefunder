class SlidesController < ApplicationController
    
    def index
        @slides = Slide.where(["pitch_id = :pitch_id", {pitch_id: params[:pitch_id]}])

        for @slide in @slides
            @slide.file_path = "uploads/#{@slide.file_path}"
        end

        render json: @slides
    end

    def show
        @slide = Slide.find(params[:id])

        render json: @slide
    end

    def create

        uploaded_file = params[:uploaded_file]
        file_path = uploaded_file.original_filename
        order = 0

        File.open(Rails.root.join('storage', 'uploads', 
        file_path), 'wb') do |file|
            file.write(uploaded_file.read)
        end

        @slide = Slide.create(file_path: file_path, order: order, pitch_id: params[:pitch_id])

        render json: @slide
    end

    def update
        @slide = Slide.find(params[:id])
        @file_path = "sample"
        @order = 0
        @slide.update(file_path: @file_path, order: @order, pitch_id: params[:pitch_id])

        render json: "#{@slide.name} has been updated"
    end

    def destroy
        @slide = Slide.find(params[:id])
        @slide.destroy

        render json: "#{@slide.name} has been deleted"
    end

end
