class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string        :title
      t.references    :user, index: true
      t.references    :tag, index: true

      t.timestamps
    end
  end
end
