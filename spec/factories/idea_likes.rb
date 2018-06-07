# frozen_string_literal: true

# == Schema Information
#
# Table name: idea_likes
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  idea_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :idea_like do
  end
end
