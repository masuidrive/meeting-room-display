class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.string :uid

      t.timestamps
    end
  end
end
