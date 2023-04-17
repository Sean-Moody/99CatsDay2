# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
	validates :username, :session_token, presence: true, uniqueness: true
	validates :password_digest, presence: true
	# validates :session_token, presence: true, uniqueness: true
	before_validation :ensure_session_token
	attr_reader :password

	def self.find_by_credentials(username, password)

		user = User.find_by(username: username) #first username is column second is argument

		if user && user.is_password?(password)
			user
		else
			nil
		end
	end

	def password=(password)
		self.password_digest = BCrypt::Password.create(password)
		@password = password #What's the point of this ivar?
	end

	def is_password?(password)
		password_object = BCrypt::Password.new(self.password_digest)
		password_object.is_password?(password)
	end

	def reset_session_token
		self.session_token = SecureRandom::urlsafe_base64
		self.save!
		self.session_token
	end

	private
	
	def generate_unique_session_token
		self.session_token ||= SecureRandom::urlsafe_base64
	end
	
end
