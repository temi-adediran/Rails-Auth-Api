class Album < ApplicationRecord
  has_many :purchases

  before_create { increment(:year) }
  attr_readonly :last_purchased_at

  def last_purchased_by
    purchases.last.user
  end
end

# == Schema Information
#
# Table name: albums
#
#  id                :bigint           not null, primary key
#  last_purchased_at :datetime
#  name              :string
#  year              :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
