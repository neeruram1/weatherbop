class Forecast
  attr_reader :id,
              :city_name,
              :country_name,
              :main_desription,
              :temp,
              :temp_min,
              :temp_max

  def initialize(forecast_info)
    @id = forecast_info[:id]
    @city_name = forecast_info[:name]
    @country_name = forecast_info[:sys][:country]
    @main_desription = forecast_info[:weather][0][:main]
    @temp = forecast_info[:main][:temp].round(0)
    @temp_min = forecast_info[:main][:temp_min].round(0)
    @temp_max = forecast_info[:main][:temp_max].round(0)
  end
end
