class Goody < ActiveRecord::Base
  has_many :orders

  validates_uniqueness_of :name
  validates_presence_of :description, :price
end
