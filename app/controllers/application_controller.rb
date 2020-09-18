class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :location, :search_params_exist?, :empty_city_country?, :empty_state?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def location
    if search_params_exist? == false
      current_user.default_location
    elsif search_params_exist? && empty_city_country?
      flash[:errors] = 'please enter missing information'
      current_user.default_location
    elsif search_params_exist? && empty_city_country? == false && empty_state? == false
      "#{params[:city]}, #{params[:state]}, #{params[:country]}".downcase
    elsif search_params_exist? && empty_city_country? == false
      "#{params[:city]}, #{params[:country]}".downcase
    end
  end

  def search_params_exist?
    params.keys.include?('city') && params.keys.include?('country') && params.keys.include?('state')
  end

  def empty_city_country?
    params[:city].empty? || params[:country].empty?
  end

  def empty_state?
    params[:state].empty?
  end
end
