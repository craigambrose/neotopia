class User < ActiveRecord::Base
  validates :email, :password, :name, presence: true
end
