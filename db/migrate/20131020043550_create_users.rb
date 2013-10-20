class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :realname, null: false
      t.string :username, null: false
      t.binary :password, null: false
      t.string :email, null: false
      t.string :customer_token, default: nil
      t.string :twitter_id, default: nil
      t.string :facebook_id, default: nil

      t.timestamps
    end
  end
end
