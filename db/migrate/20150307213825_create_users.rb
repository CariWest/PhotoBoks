class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :full_name
      t.string    :bio
      t.string    :website
      t.string    :profile_picture
      t.integer   :instagram_id
      t.string    :access_token

      t.timestamps
    end
  end
end