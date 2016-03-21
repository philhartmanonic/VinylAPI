class User < ActiveRecord::Base
	before_create :generate_authentication_token

	def generate_authentication_token
		loop do
			self.authentication_token = SecureRandom.base64(64)
			break unless User.find_by(authentication_token: authentication_token)
		end
	end
end
