# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
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

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end

    it 'set current user owner themes' do
      get :index, params: {}
      expect(
        Theme.where(id: assigns[:owner_themes].map(&:id))
             .order(:updated_at).limit(DashboardController::DISPLAY_LIMIT)
      ).to match_array owner_themes
    end

    it 'set current user joining_themes' do
      get :index, params: {}
      expect(
        Theme.where(id: assigns[:joining_themes].map(&:id))
             .order(:updated_at).limit(DashboardController::DISPLAY_LIMIT)
      ).to match_array joining_themes
    end

    it 'set current user bookmark_category_themes' do
      get :index, params: {}
      expect(
        Theme.where(id: assigns[:bookmark_category_themes].map(&:id))
             .order(:updated_at).limit(DashboardController::DISPLAY_LIMIT)
      ).to match_array bookmark_category_themes
    end
  end
end
