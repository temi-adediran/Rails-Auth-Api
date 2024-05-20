class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :album

  after_create :set_last_purchased_at
  after_create :total_purchases

  def set_last_purchased_at
    album.touch(:last_purchased_at)
  end

  def total_purchases
    increment(:total_purchases)
  end
end

# == Schema Information
#
# Table name: purchases
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#  user_id    :bigint           not null
#
