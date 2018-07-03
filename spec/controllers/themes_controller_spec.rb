# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe ThemesController, type: :controller do
  include_context 'Regist Categories'

  let!(:category) { Category.all.sample }

  # This should return the minimal set of attributes required to create a valid
  # Theme. As you add validations to Theme, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { title: 'Test Tile', description: 'Test description', category_id: category.id }
  end

  let(:invalid_attributes) do
    { title: '', description: 'Test description' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ThemesController. Be sure to keep this updated too.
  let(:user) { FactoryBot.create(:user) }
  before do
    login_user(user)
  end

  describe 'GET #index' do
    let!(:themes) do
      FactoryBot.create_list(:theme, 100, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
    end

    it 'returns a success response' do
      get :index, params: {
        category_id: themes.last.category.id, search_content: themes.last.title, order_by: :ideas_count
      }
      expect(response).to be_successful
      expect(assigns[:themes]).to be_present
    end

    context 'pagenation' do
      it 'get pagination limit' do
        get :index, params: {}
        expect(response).to be_successful
        expect(assigns[:themes].length).to eq Kaminari.config.default_per_page
      end

      it 'change page' do
        get :index, params: { page: 2 }
        expect(response).to be_successful
        expect(assigns[:themes].current_page).to eq 2
      end
    end

    context 'order' do
      it 'call order_ideas_count' do
        expect(Theme).to receive(:order_ideas_count).and_return(double('themes', page: []))
        get :index, params: { order_by: :ideas_count }
      end
    end
  end

  describe 'GET #show' do
    let!(:theme) { FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: FactoryBot.create(:category)) }
    let!(:ideas) { FactoryBot.create_list(:idea, 10, creator: FactoryBot.create(:user), theme: theme) }

    it 'returns a success response' do
      get :show, params: { id: theme.to_param }
      expect(response).to be_successful
      expect(assigns[:theme]).to eq theme
      expect(assigns[:theme].ideas).to eq ideas
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'Owner' do
      it 'returns a success response' do
        theme = FactoryBot.create(:theme, owner: user, category: FactoryBot.create(:category))
        get :edit, params: { id: theme.to_param }
        expect(response).to be_successful
      end
    end

    context 'Not Owner' do
      it 'redirect_to root' do
        theme = FactoryBot.create(:theme, owner: FactoryBot.create(:user), category: FactoryBot.create(:category))
        get :edit, params: { id: theme.to_param }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Theme' do
        expect do
          post :create, params: { theme: valid_attributes }
        end.to change(Theme, :count).by(1)
      end

      it 'redirects to the created theme' do
        post :create, params: { theme: valid_attributes }
        expect(response).to redirect_to(dashboard_index_path)
      end

      it 'attaches the uploaded file' do
        file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
        expect do
          post :create, params: { theme: valid_attributes.merge(images: [file]) }
        end.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it 'Notification Mail Category Bookmark User' do
        category.bookmark_users << FactoryBot.create(:user, email: 'bookmark_users1@examplec.com')
        category.bookmark_users << FactoryBot.create(:user, email: 'bookmark_users2@examplec.com')
        category.bookmark_users << user # Not Send Mail Owner

        expect(UserMailer).to receive(:notify_regist_theme)
          .and_return(double('mailer', deliver_later: true)).exactly(2).times
        post :create, params: { theme: valid_attributes }
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { theme: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        category = FactoryBot.create(:category)
        { title: 'New Title', description: 'New description', category_id: category.id }
      end

      it 'updates the requested theme' do
        theme = FactoryBot.create(:theme, owner: user, category: FactoryBot.create(:category))
        put :update, params: { id: theme.to_param, theme: new_attributes }
        theme.reload
        expect(theme.title).to eq 'New Title'
        expect(theme.description).to eq 'New description'
      end

      it 'redirects to the theme' do
        theme = FactoryBot.create(:theme, owner: user, category: FactoryBot.create(:category))
        put :update, params: { id: theme.to_param, theme: valid_attributes }
        expect(response).to redirect_to(theme)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        theme = FactoryBot.create(:theme, owner: user, category: FactoryBot.create(:category))
        put :update, params: { id: theme.to_param, theme: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
