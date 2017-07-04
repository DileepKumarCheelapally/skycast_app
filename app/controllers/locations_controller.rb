class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new()
    @location.city = params[:city]
    @location.user_id = session[:userid]

    # geocoding = Client.new
    #
    # geoAPIkey = "AIzaSyBpEIDuETfNoax4V9yqNp1S_NR1faM-2dA"
    #
    # # need to do this to get rid of white space and for API call
    #
    # @city = @locations.first.city.split
    #
    # if @city.count > 1
    #   @geocode = JSON.parse(geocoding.get("https://maps.googleapis.com/maps/api/geocode/json?address="+@city[0]+ @city[1]+",+"+"&key="+geoAPIkey).body)
    # else
    #   @geocode = JSON.parse(geocoding.get("https://maps.googleapis.com/maps/api/geocode/json?address="+@city[0]+",+"+"&key="+geoAPIkey).body)
    # end
    #
    # @geolocation = @geocode["results"][0]["geometry"]["location"]
    # @lat = @geolocation["lat"]
    # @lng = @geolocation["lng"]
    # @location.latitude = @lat
    # @location.longitude = @lng
    @location.save
    redirect_to controller: 'home', action: 'index'
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.permit(:city, :user_id)
    end
end
