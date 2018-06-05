# frozen_string_literal: true

module CategoriesHelper
  def nested_categories(categories, &block)
    return nested_categories(categories) { |i| "#{'-' * i.depth} #{i.name}" } unless block_given?

    result = []
    categories.map do |category, sub_categories|
      result << [yield(category), category.id, category.disp_order]
      result += nested_categories(sub_categories, &block)
    end
    result
  end
end
