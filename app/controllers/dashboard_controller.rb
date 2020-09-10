class DashboardController < ApplicationController
  def index
    @weather = ForecastFacade.new.weather
  end
end
