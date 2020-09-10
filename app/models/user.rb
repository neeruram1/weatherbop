class User < ApplicationRecord
  validates_presence_of :name, :email, :access_token, :refresh_token

  def access_token_expired?
    (Time.now - self.updated_at) > 3300
  end
end
