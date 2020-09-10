require 'rails_helper'

RSpec.describe "dashboard index page" do
  before :each do
    visit '/'

    click_on 'Login with Spotify'
  end
  it "displays current weather for a particular location" do
    visit "/dashboard"
  end
end
