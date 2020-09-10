require 'rails_helper'

describe WeatherService do
  context "instance methods" do
    context "#forecast" do
      it "returns current weather data for a particular location city, state, country" do
        VCR.use_cassette('weather_city_state_country') do
          service = WeatherService.new
          search = service.forecast("denver, co, usa")
          expect(search).to be_a Hash
          expect(search).to have_key :weather
          expect(search[:weather]).to be_an Array
          expect(search[:weather][0]).to be_a Hash
          expect(search[:weather][0]).to have_key :id
          expect(search[:weather].first).to have_key :main
          expect(search[:weather].first).to have_key :description
          expect(search[:weather].first).to have_key :icon

          expect(search).to have_key :main
          expect(search[:main]).to be_an Hash
          expect(search[:main]).to have_key :temp
          expect(search[:main]).to have_key :temp_min
          expect(search[:main]).to have_key :temp_max

          expect(search).to have_key :wind
          expect(search[:wind]).to be_a Hash

          expect(search[:name]).to eq("Denver")
        end
      end

      it "returns current weather data for a particular location city, country" do
        VCR.use_cassette('weather_city_country') do
          service = WeatherService.new
          search = service.forecast("santiago, chi")
          expect(search).to be_a Hash
          expect(search).to have_key :weather
          expect(search[:weather]).to be_an Array
          expect(search[:weather][0]).to be_a Hash
          expect(search[:weather][0]).to have_key :id
          expect(search[:weather].first).to have_key :main
          expect(search[:weather].first).to have_key :description
          expect(search[:weather].first).to have_key :icon

          expect(search).to have_key :main
          expect(search[:main]).to be_an Hash
          expect(search[:main]).to have_key :temp
          expect(search[:main]).to have_key :temp_min
          expect(search[:main]).to have_key :temp_max

          expect(search).to have_key :wind
          expect(search[:wind]).to be_a Hash

          expect(search[:name]).to eq("Santiago")
        end
      end

      it "returns current weather data for a particular location city" do
        VCR.use_cassette('weather_city') do
          service = WeatherService.new
          search = service.forecast("salt lake city")
          expect(search).to be_a Hash
          expect(search).to have_key :weather
          expect(search[:weather]).to be_an Array
          expect(search[:weather][0]).to be_a Hash
          expect(search[:weather][0]).to have_key :id
          expect(search[:weather].first).to have_key :main
          expect(search[:weather].first).to have_key :description
          expect(search[:weather].first).to have_key :icon

          expect(search).to have_key :main
          expect(search[:main]).to be_an Hash
          expect(search[:main]).to have_key :temp
          expect(search[:main]).to have_key :temp_min
          expect(search[:main]).to have_key :temp_max

          expect(search).to have_key :wind
          expect(search[:wind]).to be_a Hash

          expect(search[:name]).to eq("Salt Lake City")
        end
      end
    end
  end
end
