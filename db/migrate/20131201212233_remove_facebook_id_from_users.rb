class RemoveFacebookIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_id
  end
end
