class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: "Response was successfully created." }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: "Response was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy!

    respond_to do |format|
      format.html { redirect_to responses_path, notice: "Response was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def import
    if params[:file].present?
      begin
        ResponseImporter.import(params[:file]).process
        redirect_to responses_path, notice: "Responses imported successfully."
      rescue => e 
        # TODO: add in error handling
        redirect_back fallback_location: root_url, alert: "Error importing file: #{e.message}"
      end
    else
      redirect_back fallback_location: root_url, alert: "Please select a CSV file to import."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.expect(response: [ :survey_id, :uploader_id ])
    end
end
