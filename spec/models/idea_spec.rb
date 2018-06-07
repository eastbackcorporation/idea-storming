# frozen_string_literal: true

# == Schema Information
#
# Table name: ideas
#
#  id          :bigint(8)        not null, primary key
#  theme_id    :bigint(8)
#  ancestry    :text(65535)
#  creator_id  :bigint(8)        not null
#  title       :string(255)      not null
#  description :text(65535)
#  is_display  :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe 'association' do
    it 'should belongs to idea' do
      t = Idea.reflect_on_association(:theme)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'validation' do
    it 'presence' do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_presence_of(:description)
    end
  end
end
