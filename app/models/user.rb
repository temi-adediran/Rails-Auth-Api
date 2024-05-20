class User < ApplicationRecord
  has_many :purchases

  validates_presence_of :email, :password, :name
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: 6..20
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  def generate_token
    self.token = Digest::SHA2.base64digest(SecureRandom.hex)
  end

  def total_purchases
    purchases.count || 0
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  password   :string
#  token      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
