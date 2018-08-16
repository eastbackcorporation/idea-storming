# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::ThemesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'GET #index' do
    before do
      allow(UserMailer).to receive(:notify_register_theme).and_return(double('mailer', deliver_later: true))
    end

    let!(:owner_themes) do
      FactoryBot.create_list(:theme, 5, owner: user, category: FactoryBot.create(:category))
    end
    let!(:no_owner_themes) do
      FactoryBot.create_list(:theme, 5, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
    end
    let!(:joining_themes) do
      no_owner_themes.sample(5).each do |theme|
        theme.ideas << FactoryBot.create(:idea, creator: user, theme: theme)
      end
    end
    let!(:bookmark_category_themes) do
      user.categories << FactoryBot.create(:category)
      FactoryBot.create_list(:theme, 5, owner: FactoryBot.create(:user), category: user.categories.first)
    end

    it 'set current user owner themes' do
      get :index, params: { type: 'owner_themes' }
      expect(assigns[:themes]).to match_array owner_themes
      expect(response).to be_successful
    end

    it 'set current user joining_themes' do
      get :index, params: { type: 'joining_themes' }
      expect(assigns[:themes]).to match_array joining_themes
      expect(response).to be_successful
    end

    it 'set current user bookmark_category_themes' do
      get :index, params: { type: 'bookmark_category_themes' }
      expect(assigns[:themes]).to match_array bookmark_category_themes
      expect(response).to be_successful
    end
  end
end
