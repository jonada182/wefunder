class SlidesController < ApplicationController
    
    def index
        @slides = Slide.where(["pitch_id = :pitch_id", {pitch_id: params[:pitch_id]}])

        for @slide in @slides
            @slide.file_path = "#{@slide.file_path}"
        end

        render json: @slides
    end

    def show

        @slide = Slide.find(params[:id])

        render json: @slide

    end

    def create

        # Get file original name 

        uploaded_file = params[:uploaded_file]
        file_path = uploaded_file.original_filename

        # Return error if file uploaded is not a PDF 

        if !uploaded_file.content_type.in?(%w(application/pdf))
            return render json: {status: "error", message: "Only PDF files are allowed", code: 400}
        end

        # Retrieve and delete existing slides 

        @existingSlides = Slide.where(["pitch_id = :pitch_id", {pitch_id: params[:pitch_id]}])

        if (@existingSlides)

            for slide in @existingSlides

                file_path = Rails.root.join("public", slide.file_path)

                if File.exist?(file_path)
                    File.delete(file_path)
                end

            end

            @existingSlides.destroy_all

        end

        # Save the uploaded file 

        File.open(Rails.root.join("public", "uploads", 
        file_path), 'wb') do |file|
            file.write(uploaded_file.read)
        end

        file_path = "public/uploads/#{file_path}";

        # If file exists, convert each page to .jpg images 

        if File.exist?(file_path)

            require 'pdftoimage'

            image_file_paths = [];

            images = PDFToImage.open(file_path)
            images.each do |img|
                slide_name = "pitch-#{params[:pitch_id]}-page-#{img.page}.jpg"
                image_file_path = "public/uploads/#{slide_name}"
                img.resize('720').quality('80%').save(image_file_path)
                image_file_paths << "uploads/#{slide_name}"
            end

            # Delete uploaded PDF 

            File.delete(file_path);

            @slides = [];

            # Create Slides in the database with their respective file_path 

            for order in (0...image_file_paths.length)
    
                @slides << Slide.create(file_path: image_file_paths[order], order: order, pitch_id: params[:pitch_id])

            end
    
            render json: @slides

        else 
            render json: {status: "error", code: 400}
        end

    end

    def update
        
        @slide = Slide.find(params[:id])

        # Get file original name 

        uploaded_file = params[:uploaded_file]
        file_path = uploaded_file.original_filename

        # Save the uploaded file 

        File.open(Rails.root.join("public", "uploads", 
        file_path), 'wb') do |file|
            file.write(uploaded_file.read)
        end
        
        @slide.update(file_path: file_path)

        render json: "#{@slide.name} has been updated"

    end

    def destroy

        @slide = Slide.find(params[:id])

        file_path = Rails.root.join("public", @slide.file_path)

        if File.exist?(file_path)
            File.delete(file_path)
        end

        @slide.destroy

        render json: "#{@slide.name} has been deleted"

    end

end
