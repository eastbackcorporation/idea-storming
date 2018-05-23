require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "association" do
    it "should has many to category" do
      t = Category.reflect_on_association(:themes)
      expect(t.macro).to eq(:has_many)
    end
  end
end
