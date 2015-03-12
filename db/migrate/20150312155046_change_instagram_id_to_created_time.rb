class ChangeInstagramIdToCreatedTime < ActiveRecord::Migration
  def change
    remove_column :photos, :instagram_photo_id
    add_column    :photos, :instagram_creation_time, :integer
  end
end
