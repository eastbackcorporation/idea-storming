# frozen_string_literal: true

load(File.join(Rails.root, 'db', 'seeds', 'categories.rb'))

if Rails.env.development?
  load(File.join(Rails.root, 'db', 'seeds', 'dev', 'admin_users.rb'))
  load(File.join(Rails.root, 'db', 'seeds', 'dev', 'themes.rb'))
  load(File.join(Rails.root, 'db', 'seeds', 'dev', 'users.rb'))
end
