class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :goodie

  validates_presence_of :content
  validates :content, length: { minimum: 3 }
end
