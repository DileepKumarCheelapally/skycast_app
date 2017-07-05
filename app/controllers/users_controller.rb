class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @u = User.find_by(username: user_params["username"])

    if @u
      @userid = @u.id
      # puts @userid
      # puts "user existed"
    else
      @user = User.new()
      @user.username = user_params["username"]
      @user.save
      @userid = @user.id
      session[:userid] = @userid
      # @location = Location.new()
      # # if Rails.env.production?
      # #   request.remote_ip
      # # else
      # #   Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      # # end
      #
      # @location.city = Geocoder.search("204.57.220.1")
      # puts @location.city
      # @location.user_id = @userid
      # @location.save
      # puts @userid
      @location = Location.new()
      # if Rails.env.production?
      #   request.remote_ip
      # else
      #   Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      # end

      @loc = Geocoder.search(request.remote_ip)
      @location.city = @loc[0].city
      puts "putting location city"
      puts @location.city
      @location.user_id = @userid
      @location.save
      puts @userid
    end
    session[:userid] = @userid
    redirect_to controller: 'home', action: 'index'
#    redirect_to home_index_path, uid: @userid

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:username)
    end
end
