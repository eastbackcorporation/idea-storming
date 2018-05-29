# frozen_string_literal: true

# == Schema Information
#
# Table name: theme_tags
#
#  id         :bigint(8)        not null, primary key
#  tag_id     :bigint(8)
#  theme_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ThemeTag < ApplicationRecord
  belongs_to :theme
  belongs_to :tag
end
