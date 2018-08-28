# frozen_string_literal: true

# == Route Map
#
#                         Prefix Verb   URI Pattern                                                                              Controller#Action
#                     admin_root GET    /admin(.:format)                                                                         admin/dashboard#index
#  batch_action_admin_categories POST   /admin/categories/batch_action(.:format)                                                 admin/categories#batch_action
#               admin_categories GET    /admin/categories(.:format)                                                              admin/categories#index
#                                POST   /admin/categories(.:format)                                                              admin/categories#create
#             new_admin_category GET    /admin/categories/new(.:format)                                                          admin/categories#new
#            edit_admin_category GET    /admin/categories/:id/edit(.:format)                                                     admin/categories#edit
#                 admin_category GET    /admin/categories/:id(.:format)                                                          admin/categories#show
#                                PATCH  /admin/categories/:id(.:format)                                                          admin/categories#update
#                                PUT    /admin/categories/:id(.:format)                                                          admin/categories#update
#                                DELETE /admin/categories/:id(.:format)                                                          admin/categories#destroy
#                admin_dashboard GET    /admin/dashboard(.:format)                                                               admin/dashboard#index
#       batch_action_admin_ideas POST   /admin/ideas/batch_action(.:format)                                                      admin/ideas#batch_action
#                    admin_ideas GET    /admin/ideas(.:format)                                                                   admin/ideas#index
#                                POST   /admin/ideas(.:format)                                                                   admin/ideas#create
#                 new_admin_idea GET    /admin/ideas/new(.:format)                                                               admin/ideas#new
#                edit_admin_idea GET    /admin/ideas/:id/edit(.:format)                                                          admin/ideas#edit
#                     admin_idea GET    /admin/ideas/:id(.:format)                                                               admin/ideas#show
#                                PATCH  /admin/ideas/:id(.:format)                                                               admin/ideas#update
#                                PUT    /admin/ideas/:id(.:format)                                                               admin/ideas#update
#                                DELETE /admin/ideas/:id(.:format)                                                               admin/ideas#destroy
#    batch_action_admin_settings POST   /admin/settings/batch_action(.:format)                                                   admin/settings#batch_action
#                 admin_settings GET    /admin/settings(.:format)                                                                admin/settings#index
#                                POST   /admin/settings(.:format)                                                                admin/settings#create
#              new_admin_setting GET    /admin/settings/new(.:format)                                                            admin/settings#new
#             edit_admin_setting GET    /admin/settings/:id/edit(.:format)                                                       admin/settings#edit
#                  admin_setting GET    /admin/settings/:id(.:format)                                                            admin/settings#show
#                                PATCH  /admin/settings/:id(.:format)                                                            admin/settings#update
#                                PUT    /admin/settings/:id(.:format)                                                            admin/settings#update
#                                DELETE /admin/settings/:id(.:format)                                                            admin/settings#destroy
#        batch_action_admin_tags POST   /admin/tags/batch_action(.:format)                                                       admin/tags#batch_action
#                     admin_tags GET    /admin/tags(.:format)                                                                    admin/tags#index
#                                POST   /admin/tags(.:format)                                                                    admin/tags#create
#                  new_admin_tag GET    /admin/tags/new(.:format)                                                                admin/tags#new
#                 edit_admin_tag GET    /admin/tags/:id/edit(.:format)                                                           admin/tags#edit
#                      admin_tag GET    /admin/tags/:id(.:format)                                                                admin/tags#show
#                                PATCH  /admin/tags/:id(.:format)                                                                admin/tags#update
#                                PUT    /admin/tags/:id(.:format)                                                                admin/tags#update
#                                DELETE /admin/tags/:id(.:format)                                                                admin/tags#destroy
#      batch_action_admin_themes POST   /admin/themes/batch_action(.:format)                                                     admin/themes#batch_action
#                   admin_themes GET    /admin/themes(.:format)                                                                  admin/themes#index
#                                POST   /admin/themes(.:format)                                                                  admin/themes#create
#                new_admin_theme GET    /admin/themes/new(.:format)                                                              admin/themes#new
#               edit_admin_theme GET    /admin/themes/:id/edit(.:format)                                                         admin/themes#edit
#                    admin_theme GET    /admin/themes/:id(.:format)                                                              admin/themes#show
#                                PATCH  /admin/themes/:id(.:format)                                                              admin/themes#update
#                                PUT    /admin/themes/:id(.:format)                                                              admin/themes#update
#                                DELETE /admin/themes/:id(.:format)                                                              admin/themes#destroy
#                 admin_comments GET    /admin/comments(.:format)                                                                admin/comments#index
#                                POST   /admin/comments(.:format)                                                                admin/comments#create
#                  admin_comment GET    /admin/comments/:id(.:format)                                                            admin/comments#show
#                                DELETE /admin/comments/:id(.:format)                                                            admin/comments#destroy
#               new_user_session GET    /users/sign_in(.:format)                                                                 users/sessions#new
#                   user_session POST   /users/sign_in(.:format)                                                                 users/sessions#create
#           destroy_user_session DELETE /users/sign_out(.:format)                                                                users/sessions#destroy
#              new_user_password GET    /users/password/new(.:format)                                                            users/passwords#new
#             edit_user_password GET    /users/password/edit(.:format)                                                           users/passwords#edit
#                  user_password PATCH  /users/password(.:format)                                                                users/passwords#update
#                                PUT    /users/password(.:format)                                                                users/passwords#update
#                                POST   /users/password(.:format)                                                                users/passwords#create
#       cancel_user_registration GET    /users/cancel(.:format)                                                                  users/registrations#cancel
#          new_user_registration GET    /users/sign_up(.:format)                                                                 users/registrations#new
#         edit_user_registration GET    /users/edit(.:format)                                                                    users/registrations#edit
#              user_registration PATCH  /users(.:format)                                                                         users/registrations#update
#                                PUT    /users(.:format)                                                                         users/registrations#update
#                                DELETE /users(.:format)                                                                         users/registrations#destroy
#                                POST   /users(.:format)                                                                         users/registrations#create
#                theme_idea_hide GET    /themes/:theme_id/ideas/:idea_id/hide(.:format)                                          themes/ideas#hide
#               theme_idea_likes POST   /themes/:theme_id/ideas/:idea_id/likes(.:format)                                         themes/ideas/likes#create
#                theme_idea_like DELETE /themes/:theme_id/ideas/:idea_id/likes/:id(.:format)                                     themes/ideas/likes#destroy
#                    theme_ideas POST   /themes/:theme_id/ideas(.:format)                                                        themes/ideas#create
#                 new_theme_idea GET    /themes/:theme_id/ideas/new(.:format)                                                    themes/ideas#new
#                     theme_idea GET    /themes/:theme_id/ideas/:id(.:format)                                                    themes/ideas#show
#                 theme_mind_map PATCH  /themes/:theme_id/mind_maps/:id(.:format)                                                themes/mind_maps#update
#                                PUT    /themes/:theme_id/mind_maps/:id(.:format)                                                themes/mind_maps#update
#                  theme_watches POST   /themes/:theme_id/watches(.:format)                                                      themes/watches#create
#                    theme_watch DELETE /themes/:theme_id/watches/:id(.:format)                                                  themes/watches#destroy
#                     theme_tags POST   /themes/:theme_id/tags(.:format)                                                         themes/tags#create
#                      theme_tag DELETE /themes/:theme_id/tags/:id(.:format)                                                     themes/tags#destroy
#                         themes GET    /themes(.:format)                                                                        themes#index
#                                POST   /themes(.:format)                                                                        themes#create
#                      new_theme GET    /themes/new(.:format)                                                                    themes#new
#                     edit_theme GET    /themes/:id/edit(.:format)                                                               themes#edit
#                          theme GET    /themes/:id(.:format)                                                                    themes#show
#                                PATCH  /themes/:id(.:format)                                                                    themes#update
#                                PUT    /themes/:id(.:format)                                                                    themes#update
#                dashboard_index GET    /dashboard(.:format)                                                                     dashboard#index
#               dashboard_themes GET    /dashboard/themes(.:format)                                                              dashboard/themes#index
#             category_bookmarks GET    /category_bookmarks(.:format)                                                            category_bookmarks#show
#                                PATCH  /category_bookmarks(.:format)                                                            category_bookmarks#update
#                                PUT    /category_bookmarks(.:format)                                                            category_bookmarks#update
#          edit_settings_profile GET    /settings/profile/edit(.:format)                                                         settings/profiles#edit
#               settings_profile PATCH  /settings/profile(.:format)                                                              settings/profiles#update
#                                PUT    /settings/profile(.:format)                                                              settings/profiles#update
#         new_admin_user_session GET    /admin/users/sign_in(.:format)                                                           admin/users/sessions#new
#             admin_user_session POST   /admin/users/sign_in(.:format)                                                           admin/users/sessions#create
#     destroy_admin_user_session DELETE /admin/users/sign_out(.:format)                                                          admin/users/sessions#destroy
#        new_admin_user_password GET    /admin/users/password/new(.:format)                                                      admin/users/passwords#new
#       edit_admin_user_password GET    /admin/users/password/edit(.:format)                                                     admin/users/passwords#edit
#            admin_user_password PATCH  /admin/users/password(.:format)                                                          admin/users/passwords#update
#                                PUT    /admin/users/password(.:format)                                                          admin/users/passwords#update
#                                POST   /admin/users/password(.:format)                                                          admin/users/passwords#create
# cancel_admin_user_registration GET    /admin/users/cancel(.:format)                                                            admin/registrations#cancel
#    new_admin_user_registration GET    /admin/users/sign_up(.:format)                                                           admin/registrations#new
#   edit_admin_user_registration GET    /admin/users/edit(.:format)                                                              admin/registrations#edit
#        admin_user_registration PATCH  /admin/users(.:format)                                                                   admin/registrations#update
#                                PUT    /admin/users(.:format)                                                                   admin/registrations#update
#                                DELETE /admin/users(.:format)                                                                   admin/registrations#destroy
#                                POST   /admin/users(.:format)                                                                   admin/registrations#create
#                           root GET    /                                                                                        themes#index
#              letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
#             rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#      rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#             rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#      update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#           rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  resources :themes, only: %i[index show new create edit update] do
    resources :ideas, only: %i[create new show], module: 'themes' do
      get :hide
      resources :likes, only: %i[create destroy], module: 'ideas'
    end
    resources :mind_maps, only: %i[create update], module: 'themes'
    resources :white_boards, only: %i[create update], module: 'themes'
    resources :watches, only: %i[create destroy], module: 'themes'
    resources :tags, only: %i[create destroy], module: 'themes'
  end

  resources :dashboard, only: :index
  namespace :dashboard do
    resources :themes, only: %i[index]
  end
  resource :category_bookmarks, only: %i[show update]

  namespace :settings do
    resource :profile, only: %i[edit update] do
    end
  end

  namespace :admin do
    devise_for :users, controllers: {
      sessions: 'admin/users/sessions',
      passwords: 'admin/users/passwords',
    }
  end

  root to: 'themes#index'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
