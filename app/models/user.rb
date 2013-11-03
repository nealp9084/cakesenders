class User < ActiveRecord::Base
  has_many :orders
  has_many :comments

  validates_uniqueness_of :username, :email
  validates :email, :email => true
  validates_presence_of :username, :password_hash
  validates :username, length: { minimum: 2 }
  validates :realname, length: { minimum: 2 }

  def check_password(pw)
    if pw.length < 6 || pw.blank?
      self.errors.add(:password_hash, "must be at least 6 characters")
      return false
    else
      return true
    end
  end

  def register
    pw = self.password_hash

    rest_valid = self.valid?
    good_password = self.check_password(pw)

    if good_password && rest_valid
      self.password_hash = SCrypt::Password.create(pw)
      return self.save
    else
      return false
    end
  end

  # TODO: validation on password quality?
  def update(user_params)
    new_pw = user_params['password_hash']

    if user_params.member?('password_hash') && !new_pw.blank?
      user_params.delete('password_hash')
      self.assign_attributes(user_params)

      rest_valid = self.valid?
      good_password = self.check_password(new_pw)

      if good_password && rest_valid
        self.password_hash = SCrypt::Password.create(new_pw)
        return self.save
      else
        return false
      end
    else
      user_params.delete('password_hash') if new_pw
      return super(user_params)
    end
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    if user
      real_password = SCrypt::Password.new(user.password_hash)
      return user if real_password == password
    end

    return nil
  end
end
