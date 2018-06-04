# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IdeaLike, type: :model do
  describe 'association' do
    it 'should belongs to idea' do
      t = IdeaLike.reflect_on_association(:idea)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belongs to user' do
      t = IdeaLike.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
