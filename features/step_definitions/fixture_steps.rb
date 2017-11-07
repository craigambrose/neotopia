
Given('an existing user {string}') do |user_name|
  create(:user, user_name.downcase.to_sym)
end
