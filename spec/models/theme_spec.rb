# frozen_string_literal: true

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
