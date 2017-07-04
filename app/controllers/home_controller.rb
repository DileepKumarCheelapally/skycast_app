class HomeController < ApplicationController
  def index
    
    @locations = Location.where(user_id: session[:userid]).order('created_at DESC').limit(4)
    if @locations.count > 0
      @lat = @locations.first.latitude
      @lng = @locations.first.longitude


    	# @forecast = JSON.parse(forecasting.get("https://api.forecast.io/forecast/"+forecastAPIkey+"/"+@lat.to_s+","+@lng.to_s).body)
      @forecast = ForecastIO.forecast(@lat, @lng)

    	@currentweather = @forecast["currently"]
      @dailyWeather = @forecast["daily"]["data"].first(7)
      puts @dailyWeather.first["time"]
      @dailyWeather.shift(1)
      # for each @locations do |location|
      #   @cast = ForecastIO.forecast(location.latitude,location.longitude)
      #   @forcast.push(@cast["currently"])
      # end
    	# weather = Weather.create!(location_id: location.id, temperature: @currentweather["temperature"], clouds: @currentweather["cloudCover"], icon: @currentweather["icon"])
    end

  end

  def visualize
    @location = Location.where(user_id: session[:userid]).last
    @series_a = [1,2,3,4,5,6]
    @series_b = [3,4,6,3,6,7]
    # respond_to do |format|
    #   format.html
    #   format.json { render json: [1,2,3,4,5] }
    # end
    @sevenyears = 2592000
    @time = Time.now
    # @time = @time + @sevenyears
    # @time = @time.to_i
    if @location != nil

			@year10 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears).to_i)
			@year10temp =@year10["currently"]["temperature"]
			@year10time =@year10["currently"]["time"]
      puts @time + @sevenyears
			@year03 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears*2).to_i)
			@year03temp =@year03["currently"]["temperature"]
			@year03time =@year03["currently"]["time"]

      puts @time + @sevenyears*2

      @year96 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears*3).to_i)
      puts @time + @sevenyears*3
			@year96temp =@year96["currently"]["temperature"]
			@year96time =@year96["currently"]["time"]

      @year89 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears*4).to_i)
			@year89temp =@year89["currently"]["temperature"]
			@year89time =@year89["currently"]["time"]

      @year82 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears*5).to_i)
			@year82temp =@year82["currently"]["temperature"]
			@year82time =@year82["currently"]["time"]

      @year75 = ForecastIO.forecast(@location.latitude,@location.longitude,time: (@time - @sevenyears*6).to_i)
			@year75temp =@year75["currently"]["temperature"]
			@year75time =@year75["currently"]["time"]
			@history = [
				[Time.at(@year10time).strftime("%B, %Y"),@year10temp.to_i],
				[Time.at(@year03time).strftime("%B, %Y"),@year03temp.to_i],
				[Time.at(@year96time).strftime("%B, %Y"),@year96temp.to_i],
				[Time.at(@year89time).strftime("%B, %Y"),@year89temp.to_i],
				[Time.at(@year82time).strftime("%B, %Y"),@year82temp.to_i],
				[Time.at(@year75time).strftime("%B, %Y"),@year75temp.to_i]
			]

		end
  end

    # def data
    #   respond_to do |format|
    #     format.json {
    #       render :json => [1,2,3,4,5]
    #     }
    #   end
    # end
end
