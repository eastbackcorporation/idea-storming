# frozen_string_literal: true

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
