class AddFieldsToAlbum < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :last_purchased_at, :datetime
  end
end
