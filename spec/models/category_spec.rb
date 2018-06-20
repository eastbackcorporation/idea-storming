# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id               :bigint(8)        not null, primary key
#  name             :string(255)      not null
#  description      :text(65535)
#  disp_order       :integer
#  ancestry         :string(255)
#  category_type_id :bigint(8)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'association' do
    it 'should has many to category' do
      t = Category.reflect_on_association(:themes)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe 'association' do
    it 'should belongs to category_type' do
      t = Category.reflect_on_association(:category_type)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
