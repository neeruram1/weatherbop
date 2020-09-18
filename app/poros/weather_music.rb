class WeatherMusic
  attr_reader :location,
              :forecast_city_name,
              :forecast_country_name,
              :forecast_description,
              :forecast_main_description,
              :forecast_temp,
              :forecast_temp_min,
              :forecast_temp_max,
              :tracks

  def initialize(weather_music_info, location)
    @location = location
    @forecast_city_name = weather_music_info[:data][:weather][:attributes][:city_name]
    @forecast_country_name = weather_music_info[:data][:weather][:attributes][:country_name]
    @forecast_description = weather_music_info[:data][:weather][:attributes][:description]
    @forecast_main_description = weather_music_info[:data][:weather][:attributes][:main_description]
    @forecast_temp = weather_music_info[:data][:weather][:attributes][:temp]
    @forecast_temp_min = weather_music_info[:data][:weather][:attributes][:temp_min]
    @forecast_temp_max = weather_music_info[:data][:weather][:attributes][:temp_max]
    @tracks = weather_music_info[:data][:music][:attributes].map {|track_data| Track.new(track_data)}
    @unprocessed_tracks = weather_music_info[:data][:music][:attributes]
  end

  def url(index)
    "https://open.spotify.com/embed?uri=#{@tracks[index].uri}"
  end

  def processed_tracks
    @unprocessed_tracks.map do |track|
      track[:uri]
    end.join(',')
  end
end
