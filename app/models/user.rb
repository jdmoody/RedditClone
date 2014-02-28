# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  before_validation :set_session_token

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :subs, foreign_key: :moderator_id, inverse_of: :moderator
  has_many :links

  attr_accessor :password

  def set_session_token
    self.session_token = self.class.generate_session_token
  end

  def reset_session_token
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password).to_s
  end

  def is_password?(unencrypted_password)
     BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(user_params)
    user = User.find_by(username: user_params[:username])
    return user if user && user.is_password?(user_params[:password])
  end
end
