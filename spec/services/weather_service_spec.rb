require 'rails_helper'

describe WeatherService do
  context "instance methods" do
    context "#forecast" do
      it "returns current weather data for a particular location" do
        VCR.use_cassette('weather_by_location') do
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
    end
  end
end
