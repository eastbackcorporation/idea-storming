# frozen_string_literal: true

def register_category(category, parent, category_type_name)
  category_type = CategoryType.find_by(type_name: category_type_name)

  if category.is_a?(Hash)
    c = Category.find_or_initialize_by(name: category.keys.first, category_type_id: category_type.id)
    c.save!
    category.values.flatten.each do |cc|
      if cc.is_a?(Hash)
        ccc = Category.find_or_initialize_by(name: category, category_type_id: category_type.id)
        ccc.save
        parent = ccc
      else
        parent = c
      end
      register_category(cc, parent, category_type)
    end
  elsif parent.present?
    parent.children.create(name: category, category_type_id: category_type.id)
  else
    c = Category.find_or_initialize_by(name: category, category_type_id: category_type.id)
    c.save!
  end
end

YAML.safe_load(
  File.open(Rails.root.join('db', 'masters', 'categories.yml')).read
).each do |category_type_name, categories|
  categories.each do |category|
    register_category(category, nil, category_type_name)
  end
end
