class AddColumnForInstagramUrl < ActiveRecord::Migration
  def change
    add_column :photos, :instagram_url, :string
  end
end
