class AddCoverPhotoToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :cover, :string, default: "http://www.giladorigami.com/P_Unicorn_Diaz.jpg"
  end
end
