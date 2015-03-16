class SongsController < ApplicationController
  include SongsHelper

  def index
    mood  = params[:mood] ? params[:mood] : ""
    genre = params[:genre] ? params[:genre] : ""
    if mood != ""
      songs = get_songs(genre, mood)
    end
    respond_to do |format|
      format.html
      format.json { render json: {songs: songs} }
    end
  end

  def create
    #Use Zip class method to validate location in US
    location = Zip.validate_zip(params[:zip_code])
    if location
      # #either send the data back up or use it to go weather api call
      # end
    else
      respond_to do |format|
        format.json {render json: nil}
      end
    end
  end

  def zip_weather
    valid_zip(params[:zip_code])
    case @location_weather
    when @location_weather = "Thunderstorm" || location_weather = "Drizzle" || location_weather = "Rain" || location_weather = "Extreme"
      type_of_weather = "Rain"
    when @location_weather = "Snow" || location_weather = "Atmosphere"
      type_of_weather = "Snow"
    when @location_weather = "Clouds"
      type_of_weather = "Cloudy"
    when @weather["weather"].first["description"] == "clear sky"
      type_of_weather = "Clear"
    end
    @type_of_weather = type_of_weather

    data = {
      type_of_weather: @type_of_weather,
      time_of_day: @time_of_day,
      location_temp: @location_temp
    }

    render json: data
  end

  def sun_position(sunrise, sunset)
    unix_time = Time.now.to_i
    if unix_time > sunset
      @time_of_day = "Night"
    elsif unix_time < sunset && unix_time > sunrise
      @time_of_day = "Day"
    else
      @time_of_day = "Night"
    end
  end

  def weather_info(weather)
    @weather = weather
    @location_weather = weather["weather"].first["main"]
    @location_temp = (1.8 * (weather["main"]["temp"] - 273) + 32).to_i
  end

  def valid_zip(zip_code)
    weather_data = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{zip_code}&APPID=5931f50a22af92b8b5294d2a09d5b876")
    if weather_data["sys"]["country"] != "US"
      flash[:notice] = "We're having connection issues. Please try again."
    else
      weather_info(weather_data)
      sun_position(weather_data["sys"]["sunrise"], weather_data["sys"]["sunset"])
    end
  end

end
