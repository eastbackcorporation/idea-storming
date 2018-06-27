# frozen_string_literal: true

class CategoryBookmark < ApplicationRecord
  belongs_to :category
  belongs_to :user
end
