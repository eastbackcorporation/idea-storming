# frozen_string_literal: true

class Setting < ApplicationRecord
  validates :name, uniqueness: true

  class << self
    def [](name)
      find_by(name: name)&.value
    end
  end
end
