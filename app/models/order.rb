class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :goodie
  validates_uniqueness_of :charge_token
end
