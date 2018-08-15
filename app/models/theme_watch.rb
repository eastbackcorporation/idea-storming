# frozen_string_literal: true

class ThemeWatch < ApplicationRecord
  belongs_to :theme
  belongs_to :user
end
