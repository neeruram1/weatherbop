class WeatherMusicFacade
  attr_reader :location,
              :token

  def initialize(token, location)
    @location = location
    @token = token
    @weather_music_service = WeatherMusicService.new
  end

  def weather_music
    unless results_weather_music[:data][:type] == 'error'
      WeatherMusic.new(results_weather_music, @location)
    end
  end

  def results_weather_music
    @weather_music_service.weather_music(@token, @location)
  end
end
