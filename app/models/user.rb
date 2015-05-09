require 'bcrypt'

class User < ActiveRecord::Base
  has_many :my_surveys, class_name: 'Survey', foreign_key: 'creator_id'
  has_many :answers
  has_many :taken_surveys, class_name: 'Survey', through: :answers, source: :survey

  def password
    @password ||= BCrypt::Password.new(password_hash) if password_hash.present?
  end

  def password=(set_password)
    @password = BCrypt::Password.create(set_password)
    self.password_hash = @password
  end
end
