# frozen_string_literal: true

def register_category(category, parent)
  if category.is_a?(Hash)
    c = Category.find_or_initialize_by(name: category.keys.first)
    c.save
    category.values.flatten.each do |cc|
      if cc.is_a?(Hash)
        ccc = Category.find_or_initialize_by(name: category)
        ccc.save
        parent = ccc
      else
        parent = c
      end
      register_category(cc, parent)
    end
  else
    if parent.present?
      parent.children.create(
        name: category
      )
    else
      c = Category.find_or_initialize_by(name: category)
      c.save
    end
  end
end

YAML.safe_load(File.open(Rails.root.join('db', 'seeds', 'categories.yml')).read).each do |category|
  register_category(category, nil)
end
