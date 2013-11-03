class AddImageUrlToGoodies < ActiveRecord::Migration
  def change
    add_column :goodies, :image_url, :string
  end
end
