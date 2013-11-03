class CreateGoodies < ActiveRecord::Migration
  def change
    create_table :goodies do |t|
      t.string :name, null: false, unique: true
      t.text :description, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
