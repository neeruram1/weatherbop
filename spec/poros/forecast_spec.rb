require 'rails_helper'

describe Forecast do
  it 'exists' do
    attrs = {
      id: 1234567,
      name: "Denver",
      sys: {
        country: "US",
      },
      main: {
        temp: 46.15,
        temp_min: 44.01,
        temp_max: 48,
      },
      weather: [{
          main: "Clouds"
        }]
    }

    weather = Forecast.new(attrs)

    expect(weather).to be_a Forecast
    expect(weather.id).to eq(1234567)
    expect(weather.city_name).to eq("Denver")
    expect(weather.country_name).to eq("US")
    expect(weather.temp).to eq(46)
    expect(weather.temp_min).to eq(44)
    expect(weather.temp_max).to eq(48)
    expect(weather.main_desription).to eq("Clouds")
  end
end
