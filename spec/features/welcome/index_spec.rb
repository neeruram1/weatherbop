require 'rails_helper'

RSpec.describe 'welcome page' do
  before(:each) do
    @auth_data = {
      'provider'  => 'spotify',
      'info' => {
        'display_name' => 'Neeru Ram',
        'id'           => '12345',
        'email'         => 'neeram85@gmail.com'
      },
      'credentials' => {
        'token'         => "BQB7UoqyJtAyfPH3UFO_SGcS0nilrLoxq4kNXbAtJJd2GJbGRsiBsYgL6UmeR96ddqXIOtVHgMVL05Frg-Ck3AOECMuH9KpCpofeG-oBYmTPd12q9zJiqgRu1BxMEzBwAQGpQQQWmdvNJ7do9gm0mkLYC2k-QLoz2x_hruK3YI2kE2WKNQiYR55Xf1oV5jWMMY2o1ZwwsaBzOjUnqX9iGkZ3X5oJsmXBX_A1FfFzH9QaMa4",
        'refresh_token' => "AQBrHoXiwQEihJiJOqTCBelpj1IKRGoGM_KY6aYy2cQ-cZc-i-ao58gDlFv8rb3HzRSUbyWoFGLQquUwvxDLVZ0UJEnFRIrpHqpBZvCKVGQO9xhjOPW-xz-EUqStBYEhh50",
      }
    }
  end
  describe 'login path' do
    it "Displays the name of the application" do
      visit root_path

      expect(page).to have_content("weather-bop")
    end

    it "New user can sign in with spotify", :vcr do
      OmniAuth.config.mock_auth[:spotify] = @auth_data

      visit root_path

      click_link('login')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("welcome, #{@auth_data['info']['display_name']}".downcase)
    end

    it "Existing user can sign in with spotify", :vcr do
      neeru = User.create(
        spotify_id: @auth_data["info"]["id"],
        name: @auth_data["info"]["display_name"],
        access_token: @auth_data["credentials"]["token"],
        refresh_token: @auth_data["credentials"]["refresh_token"],
        email: @auth_data["info"]["email"]
      )
      OmniAuth.config.mock_auth[:spotify] = @auth_data

      visit root_path

      click_link('login')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("welcome, #{neeru.name.downcase}")
    end

    it "has a link to register with spotify" do
      visit root_path

      expect(page).to have_content("don't have a spotify account?")
      expect(page).to have_link('register here', href: 'https://www.spotify.com/us/')
    end

    it "redirects to welcome page if authorization fails" do
      OmniAuth.config.mock_auth[:spotify] = :invalid_credentials

      visit root_path

      click_link('login')
      expect(current_path).to eq(root_path)
      expect(page).to have_content("invalid credentials, please try logging in again")
    end
  end
  describe 'logout path' do
    it "user can logout", :vcr do
      neeru = User.create(
        spotify_id: @auth_data["info"]["id"],
        name: @auth_data["info"]["display_name"],
        access_token: @auth_data["credentials"]["token"],
        refresh_token: @auth_data["credentials"]["refresh_token"],
        email: @auth_data["info"]["email"]
      )
      OmniAuth.config.mock_auth[:spotify] = @auth_data

      visit root_path

      within "nav" do
       expect(page).to_not have_link('logout')
       expect(page).to_not have_link('change default location')
      end

      click_link('login')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("welcome, #{neeru.name.downcase}")

      within 'nav' do
        expect(page).to_not have_link('login')
        expect(page).to have_link('change default location')
        click_link('logout')
      end

      expect(current_path).to eq(root_path)

      within 'nav' do
       expect(page).to_not have_link('logout')
       expect(page).to_not have_link('change default location')
      end

      expect(page).to have_link('login')
    end
  end
end
