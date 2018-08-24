# frozen_string_literal: true

# == Schema Information
#
# Table name: category_bookmarks
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)        not null
#  category_id :bigint(8)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CategoryBookmark < ApplicationRecord
  belongs_to :category
  belongs_to :user
end
