class FactoryHelpers
  extend Users::Passwords
end

FactoryGirl.define do
  factory :user do
    trait :michael do
      uuid 'michael1'
      name 'Michael'
      email 'michael@user.com'
      encrypted_password { FactoryHelpers.encrypt_password('grokthis') }
    end
  end
end
