class SetDefaultCoverPhotoToNil < ActiveRecord::Migration
  def change
    change_column_default :albums, :cover, nil
  end
end
