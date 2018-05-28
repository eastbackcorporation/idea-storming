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

require 'rails_helper'

RSpec.describe ThemeTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
