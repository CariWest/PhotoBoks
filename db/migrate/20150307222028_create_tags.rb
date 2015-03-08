class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string           :tag
      t.references  :album
      t.references  :photo

      t.timestamps
    end
  end
end
