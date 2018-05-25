# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Themes::IdeasController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'POST #create' do
    let!(:theme) { FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: FactoryBot.create(:category)) }

    let!(:valid_attributes) do
      {
        title: 'Idea Title',
        description: 'Idea Description'
      }
    end

    let!(:invalid_attributes) do
      {
        title: '',
        description: 'Idea Description'
      }
    end

    context 'regist root idea' do
      context 'with valid params' do
        it 'creates a New Idea' do
          expect do
            post :create, params: { theme_id: theme.id, idea: valid_attributes }
          end.to change(theme.ideas.roots, :count).by(1)

          expect(theme.ideas.roots.last).to have_attributes valid_attributes
          expect(theme.ideas.roots.last.creator).to eq user
        end

        it 'redirects to the theme page' do
          post :create, params: { theme_id: theme.id, idea: valid_attributes }
          expect(response).to redirect_to(theme)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the theme 'show' template)" do
          post :create, params: { theme_id: theme.id, idea: invalid_attributes }
          expect(response).to be_successful
        end
      end

      include_examples 'Can Not Access If Not Login' do
        subject { post :create, params: { theme_id: theme.id, idea: valid_attributes } }
      end
    end

    context 'regist child idea' do
      let!(:parent_idea) { FactoryBot.create(:idea, creator: FactoryBot.create(:user), theme: theme) }

      context 'with valid params' do
        it 'creates a New Child Idea' do
          expect do
            post :create, params: { theme_id: theme.id, parent_id: parent_idea, idea: valid_attributes }
          end.to change(parent_idea.children, :count).by(1)

          expect(parent_idea.children.last).to have_attributes valid_attributes
          expect(parent_idea.children.last.creator).to eq user
        end

        it 'redirects to the theme page' do
          post :create, params: { theme_id: theme.id, parent_id: parent_idea, idea: valid_attributes }
          expect(response).to redirect_to(theme)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the theme 'show' template)" do
          post :create, params: { theme_id: theme.id, parent_id: parent_idea, idea: invalid_attributes }
          expect(response).to be_successful
        end
      end

      include_examples 'Can Not Access If Not Login' do
        subject { post :create, params: { theme_id: theme.id, parent_id: parent_idea, idea: valid_attributes } }
      end
    end
  end
end
