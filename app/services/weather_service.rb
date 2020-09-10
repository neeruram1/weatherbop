class WeatherService
  def forecast(location)
    result = conn.get("/data/2.5/weather?q=#{location}&units=imperial&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
    JSON.parse(result.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
