# frozen_string_literal: true

user = User.find_or_initialize_by(nick_name: 'demo_user')
user.email = 'demo@example.com'
user.password = 'password'
user.password_confirmation = 'password'
user.save
