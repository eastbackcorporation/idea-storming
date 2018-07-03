# frozen_string_literal: true

module ThemesHelper
  def active_category_tab?(theme, category_type)
    return CategoryType.first == category_type if theme.category.blank?

    theme.category.category_type == category_type
  end
end
