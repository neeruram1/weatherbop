class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
    @weather_service = WeatherService.new
  end

  def weather
    forecast_info = results_forecast

    @weather = Forecast.new(forecast_info)
  end

  def results_forecast
    @weather_service.forecast(@location)
  end
end
