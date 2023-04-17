class User < ApplicationRecord
	validates :username, :session_token, presence: true, uniqueness: true
	validates :password_digest, presence: true
	# validates :session_token, presence: true, uniqueness: true
	before_validation :ensure_session_token

	def password=(password)
		self.password_digest = BCrypt::Password.create(password)
		@password = password #What's the point of this ivar?
	end

	def is_password?(password)
		password_object = BCrypt::Password.new(self.password_digest)
		password_object.is_password?(password)
	end

	
end
