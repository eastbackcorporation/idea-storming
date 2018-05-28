# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'GET #index' do
    let!(:owner_themes) do
      FactoryBot.create_list(:theme, 10, owner: user, category: FactoryBot.create(:category))
    end
    let!(:no_owner_themes) do
      FactoryBot.create_list(:theme, 20, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
    end
    let!(:joining_themes) do
      no_owner_themes.sample(5).each do |theme|
        theme.ideas << FactoryBot.create(:idea, creator: user, theme: theme)
      end
    end

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end

    it 'set current user owner themes' do
      get :index, params: {}
      expect(assigns[:owner_themes]).to match_array owner_themes
    end

    it 'set current user joining_themes' do
      get :index, params: {}
      expect(assigns[:joining_themes]).to match_array joining_themes
    end
  end
end
