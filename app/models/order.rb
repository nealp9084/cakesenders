class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :goodie

  validates_uniqueness_of :charge_token
  validates_presence_of :charge_token, :destination
  validates :destination, length: { minimum: 5 }
end
