class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, null: false
      t.references :goodie, index: true, null: false
      t.text :destination, null: false
      t.string :charge_token, null: false

      t.timestamps
    end
  end
end
