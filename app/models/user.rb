class User < ApplicationRecord
  validates_presence_of :email, :password, :name
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: 6..20
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  def generate_token
    self.token = Digest::SHA2.base64digest(SecureRandom.hex)
  end
end
