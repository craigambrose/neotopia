FactoryGirl.define do
  factory :user do
    trait :michael do
      name 'Michael'
      email 'michael@user.com'
      password 'grokthis'
    end
  end
end
