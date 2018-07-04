# frozen_string_literal: true

6.times do |i|
  user = User.find_or_initialize_by(nick_name: "demo_user_#{i}")
  user.email = "demo_#{i}@example.com"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save
end
