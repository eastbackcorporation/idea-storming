# frozen_string_literal: true

category_types =
  YAML.load_file(Rails.root.join('db', 'masters', 'category_types.yml'))

category_types.each_with_index do |(type_name, value), i|
  puts "#{value['id']}: #{type_name}"
  ct = CategoryType.find_or_initialize_by(id: value['id'].to_i)
  ct.type_name = type_name
  ct.name = value['name']
  ct.disp_order = i
  ct.save!
end
