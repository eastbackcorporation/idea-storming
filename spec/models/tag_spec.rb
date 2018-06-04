# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  disp_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'association' do
    it 'should has many theme_tags' do
      t = Tag.reflect_on_association(:theme_tags)
      expect(t.macro).to eq(:has_many)
    end

    it 'should has many themes' do
      t = Tag.reflect_on_association(:themes)
      expect(t.macro).to eq(:has_many)
    end
  end
end
