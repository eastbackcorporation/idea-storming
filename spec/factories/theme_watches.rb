# frozen_string_literal: true

# == Schema Information
#
# Table name: theme_watches
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  theme_id   :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :theme_watch do
  end
end
