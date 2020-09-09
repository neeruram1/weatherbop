class Api::V1::DefaultUser::BaseController < ApplicationController
  before_action :require_default_user

  def require_default_user
      render file: "/public/404" unless current_default_user?
  end
end 