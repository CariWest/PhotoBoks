class AddColumnsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :instagram_photo_id, :integer
    add_column :photos, :caption, :string
  end
end