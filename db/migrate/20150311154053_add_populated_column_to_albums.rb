class AddPopulatedColumnToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :populated, :boolean, default: false
  end
end
