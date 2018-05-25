# frozen_string_literal: true

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
