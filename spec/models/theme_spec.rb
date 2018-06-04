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

  describe 'scope' do
    describe '.include_category' do
      let!(:major_categories) { FactoryBot.create_list(:category, 5) }
      let!(:target_major_category) { major_categories.first }
      let!(:sub_categories) { FactoryBot.create_list(:category, 3, parent: target_major_category) }

      let!(:other_themes) do
        FactoryBot.create_list(:theme, 10, owner: FactoryBot.create(:user), category: major_categories.last)
      end

      it 'specify major category' do
        target_themes = []
        target_themes << FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: target_major_category)
        sub_categories.each do |ct|
          target_themes << FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: ct)
        end

        expect(Theme.include_category(target_major_category)).to match target_themes
      end

      it 'specify sub category' do
        FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: target_major_category)
        sub_categories.each do |ct|
          FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: ct)
        end

        expect(Theme.include_category(sub_categories[0])).to match sub_categories[0].themes
        expect(Theme.include_category(sub_categories[1])).to match sub_categories[1].themes
        expect(Theme.include_category(sub_categories[2])).to match sub_categories[2].themes
      end
    end

    describe '.search_content' do
      let!(:other_themes) do
        FactoryBot.create_list(:theme, 10, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
      end

      context 'only title match' do
        let!(:title) { '### Title Name xxxxx' }
        let!(:target_theme) do
          FactoryBot.create(:theme, owner: FactoryBot.create(:user),
                                    title: title, category: FactoryBot.create(:category))
        end

        it 'get target theme' do
          expect(Theme.search_content('Title Name xx')).to match [target_theme]
        end
      end

      context 'only description match' do
        let!(:description) { "\n description  content !!!" }
        let!(:target_theme) do
          FactoryBot.create(:theme, owner: FactoryBot.create(:user), description: description,
                                    category: FactoryBot.create(:category))
        end

        it 'get target theme' do
          expect(Theme.search_content('description  c')).to match [target_theme]
        end
      end

      context 'only tag name match' do
        let!(:tag_name) { '!!! Tag Name !!!' }
        let!(:target_theme) do
          FactoryBot.create(:theme, owner: FactoryBot.create(:user),
                                    category: FactoryBot.create(:category), tags: [Tag.new(name: tag_name)])
        end

        it 'get target theme' do
          expect(Theme.search_content('Tag Name')).to match [target_theme]
        end
      end

      context 'OR compound condition' do
        let!(:title) { '### Title Name ABC xxxxx' }
        let!(:description) { "\n  ABC description  content !!!" }
        let!(:tag_name) { '!!!  ABC  !!!' }

        let!(:target_themes) do
          [
            FactoryBot.create(:theme, owner: FactoryBot.create(:user),
                                      title: title, category: FactoryBot.create(:category)),
            FactoryBot.create(:theme, owner: FactoryBot.create(:user),
                                      description: description, category: FactoryBot.create(:category)),
            FactoryBot.create(:theme, owner: FactoryBot.create(:user),
                                      category: FactoryBot.create(:category), tags: [Tag.new(name: tag_name)])
          ]
        end

        it 'get target themes' do
          expect(Theme.search_content('ABC')).to match target_themes
        end
      end
    end
  end
end
