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
  describe 'association' do
    it 'should belongs to theme' do
      t = ThemeTag.reflect_on_association(:theme)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belongs to tag' do
      t = ThemeTag.reflect_on_association(:tag)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
