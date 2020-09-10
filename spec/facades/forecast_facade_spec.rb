require 'rails_helper'

RSpec.describe ForecastFacade do
  describe "instance methods" do
    describe "#weather" do
      facade = ForecastFacade.new("denver, co, usa")
      weather = facade.weather
      expect(weather).to be_a Forecast
    end

    describe "#results_forecast" do
      it "returns parsed hash of JSON data for weather for that location" do
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
