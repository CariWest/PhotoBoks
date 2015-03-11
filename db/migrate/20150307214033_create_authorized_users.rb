class CreateAuthorizedUsers < ActiveRecord::Migration
  def change
    create_table :authorized_users do |t|
      t.references    :user, index: true
      t.references    :album, index: true

      t.timestamps
    end
  end
end
