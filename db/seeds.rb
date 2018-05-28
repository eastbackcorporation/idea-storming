# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_initialize_by(nick_name: 'demo_user')
user.email = 'demo@example.com'
user.password = 'password'
user.password_confirmation = 'password'
user.save

(1..10).each do |i|
  category = Category.find_or_initialize_by(name: "Category#{i}") do |c|
    c.description = "Description#{i}"
    c.disp_order = i
  end

  next unless category.new_record?
  category.save

  3.times do |ii|
    category.children.create(
      name: (category.name * 2) + ii.to_s,
      description: (category.description * 2) + ii.to_s,
      disp_order: category.disp_order
    )
  end
end
