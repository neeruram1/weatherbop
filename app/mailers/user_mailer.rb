class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(
      to: @user.email, 
      subject: 'Welcome to WeatherBop!',
      from: 'josh.tukman@gmail.com',
      reply_to: 'example_email@gmail.com')
  end
end
