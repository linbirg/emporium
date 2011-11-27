#require "digest/sha2"

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  # password is a virtual attribute for writing hash_password
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def self.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "linbirg" + salt)
  end

  private

  def password_must_be_present
    errors.add(:password, 'Missing password') unless hashed_password.present?
  end

  def generate_salt
    self.salt =  self.object_id.to_s + rand.to_s
  end

end
