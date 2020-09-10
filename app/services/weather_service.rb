class WeatherService
  def forecast(location)
    params = {units: 'imperial', q: "#{location}" }
    result = conn.get("/data/2.5/weather", params)
    JSON.parse(result.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      faraday.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end
end
