# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Setting < ApplicationRecord
  validates :name, uniqueness: true

  class << self
    def [](name)
      find_by(name: name)&.value
    end
  end
end
