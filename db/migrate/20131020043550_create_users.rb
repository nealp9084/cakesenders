class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :realname, null: false
      t.string :username, null: false
      t.string :password_hash, null: false
      t.string :email, null: false
      t.string :customer_token, default: nil
      t.string :twitter_id, default: nil
      t.string :facebook_id, default: nil
      t.boolean :admin, default: false, null: false

      t.timestamps
    end
  end
end
