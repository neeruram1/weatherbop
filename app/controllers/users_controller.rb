class UsersController < ApplicationController
  def show
    @weather_music = WeatherMusicFacade.new(current_user.token, location).weather_music

    if @weather_music.nil?
      redirect_to dashboard_path
      flash[:errors] = 'invalid city'
    else
      @weather_music
    end
  end

  def update
    user = User.find(current_user.id)
    user.update(default_location: location)
    user.save!
    flash[:success] = 'Your default location has been updated'
    redirect_to dashboard_path
  end
end
