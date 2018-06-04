# frozen_string_literal: true

admin_user = User.find_or_initialize_by(nick_name: 'admin_admin_user')
admin_user.email = 'admin@example.com'
admin_user.password = 'password'
admin_user.password_confirmation = 'password'
admin_user.is_admin = true
admin_user.save
