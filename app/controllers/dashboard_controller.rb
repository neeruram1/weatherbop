class DashboardController < ApplicationController
  def index
    location = "denver, co, usa"
    forecast_facade = ForecastFacade.new(location)
    @weather = forecast_facade.weather
  end
end
