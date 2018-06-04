# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Themes::Ideas::LikesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'POST #create' do
    let!(:theme) do
      theme = FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
      theme.ideas << FactoryBot.create(:idea, creator: user, theme: theme)
      theme
    end

    let!(:idea) do
      theme.ideas.first
    end

    context 'like idea' do
      it 'create like' do
        expect do
          post :create, xhr: true, params: { theme_id: theme.id, idea_id: idea.id }
        end.to change(IdeaLike, :count).by(1)
      end

      it 'returns a success response ' do
        post :create, xhr: true, params: { theme_id: theme.id, idea_id: idea.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:theme) do
      theme = FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
      theme.ideas << FactoryBot.create(:idea, creator: user, theme: theme)
      theme
    end

    let!(:idea) do
      theme.ideas.first
    end

    let!(:like) do
      idea.likes.build(user: user)
      idea.save
      idea.likes.first
    end

    context 'unlike idea' do
      it 'destroy like' do
        expect do
          delete :destroy, xhr: true, params: { theme_id: theme.id, idea_id: idea.id, id: like.id }
        end.to change(IdeaLike, :count).by(-1)
      end

      it 'returns a success response ' do
        delete :destroy, xhr: true, params: { theme_id: theme.id, idea_id: idea.id, id: like.id }
        expect(response).to be_successful
      end
    end
  end
end
