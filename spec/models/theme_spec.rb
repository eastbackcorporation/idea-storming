require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe "validation" do
    it "presence" do
      is_expected.to validate_presence_of(:title)
    end
  end
end
