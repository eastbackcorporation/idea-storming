# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  owner_id    :bigint(8)        not null
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe 'association' do
    it 'should belongs to category' do
      t = Theme.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'validation' do
    it 'presence' do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_presence_of(:category)
    end
  end
end
