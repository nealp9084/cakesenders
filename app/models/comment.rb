class Comment < ActiveRecord::Base
  belongs_to :goodie
  belongs_to :user
end
