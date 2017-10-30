module Users
  module Passwords
    def encrypt_password(password)
      raise ArgumentError, "password can't be blank" if password.blank?
      BCrypt::Password.create(password, cost: 10)
    end
  end
end
