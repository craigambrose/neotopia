class User < ActiveRecord::Base
  validates :uuid, :email, :encrypted_password, :name, presence: true
end
