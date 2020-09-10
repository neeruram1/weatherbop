require 'rails_helper'

RSpec.describe ForecastFacade do
  describe "instance methods" do
    describe "#weather" do
      it "returns a forecast object with the current weather for that location" do
        VCR.use_cassette('weather_city_state_country') do
          facade = ForecastFacade.new("denver, co, usa")
          weather = facade.weather
          expect(weather.city_name).to eq("Denver")
          expect(weather.country_name).to eq("US")
          expect(weather.main_desription).to_not eq(nil)
          expect(weather.temp).to_not eq(nil)
          expect(weather.temp_min).to_not eq(nil)
          expect(weather.temp_max).to_not eq(nil)
        end
      end
    end

    describe "#results_forecast" do
      it "returns parsed hash of JSON data for weather for that location" do
        VCR.use_cassette('weather_city_state_country') do
          facade = ForecastFacade.new("denver, co, usa")
          result = facade.results_forecast
          expect(result).to be_a Hash
          expect(result).to have_key :weather
          expect(result[:weather]).to be_an Array
          expect(result[:weather][0]).to be_a Hash
          expect(result[:weather][0]).to have_key :id
          expect(result[:weather].first).to have_key :main
          expect(result[:weather].first).to have_key :description
          expect(result[:weather].first).to have_key :icon

          expect(result).to have_key :main
          expect(result[:main]).to be_an Hash
          expect(result[:main]).to have_key :temp
          expect(result[:main]).to have_key :temp_min
          expect(result[:main]).to have_key :temp_max

          expect(result).to have_key :wind
          expect(result[:wind]).to be_a Hash

          expect(result[:name]).to eq("Denver")
        end
      end
    end
  end
end
