# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryBookmarksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: {}
      expect(response).to be_successful
      expect(assigns[:user]).to eq user
    end
  end

  describe 'PATCH #update' do
    include_context 'Regist Categories'

    let!(:target_categories) { Category.all.sample(2) }

    it 'Regist Category Bookmarks' do
      patch :update, params: { user: {
        category_bookmarks_attributes: [
          { category_id: target_categories[0].id }, { category_id: target_categories[1].id }
        ]
      } }
      expect(user.categories).to match target_categories
    end

    it 'Update Category Bookmarks' do
      user.categories = Category.all.sample(5)
      patch :update, params: { user: {
        category_bookmarks_attributes: [
          { category_id: target_categories[0].id }, { category_id: target_categories[1].id }
        ]
      } }
      user.reload
      expect(user.categories).to match target_categories
    end

    it 'redirects to the dashbord page' do
      patch :update, params: { user: {
        category_bookmarks_attributes: [
          { category_id: target_categories[0].id }, { category_id: target_categories[1].id }
        ]
      } }
      expect(response).to redirect_to dashboard_index_path
    end
  end
end
