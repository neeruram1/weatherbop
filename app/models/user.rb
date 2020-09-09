class User < ApplicationRecord
  enum role: {default: 0, admin: 1}
  def access_token_expired?
    (Time.now - self.updated_at) > 3300
  end
end 