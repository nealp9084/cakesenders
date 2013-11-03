class Goodie < ActiveRecord::Base
  has_many :orders
  has_many :comments

  validates_uniqueness_of :name
  validates_presence_of :description, :price
  validate :good_image_url

  def good_image_url
    unless image_url.blank?
      u = URI::regexp(%w(http https))

      unless u.match(image_url)
        errors.add(:image_url, 'must be a valid URL')
      end
    end
  end
end
