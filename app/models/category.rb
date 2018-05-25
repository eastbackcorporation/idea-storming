# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  disp_order  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ApplicationRecord
  has_many :themes
end
