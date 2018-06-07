# frozen_string_literal: true

# == Route Map
#
#                         Prefix Verb   URI Pattern                                                                              Controller#Action
#                     admin_root GET    /admin(.:format)                                                                         admin/dashboard#index
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
#  batch_action_admin_categories POST   /admin/categories/batch_action(.:format)                                                 admin/categories#batch_action
#               admin_categories GET    /admin/categories(.:format)                                                              admin/categories#index
#                                POST   /admin/categories(.:format)                                                              admin/categories#create
#             new_admin_category GET    /admin/categories/new(.:format)                                                          admin/categories#new
#            edit_admin_category GET    /admin/categories/:id/edit(.:format)                                                     admin/categories#edit
#                 admin_category GET    /admin/categories/:id(.:format)                                                          admin/categories#show
#                                PATCH  /admin/categories/:id(.:format)                                                          admin/categories#update
#                                PUT    /admin/categories/:id(.:format)                                                          admin/categories#update
#                                DELETE /admin/categories/:id(.:format)                                                          admin/categories#destroy
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
#               new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                   user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#           destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#              new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#             edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                  user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                PUT    /users/password(.:format)                                                                devise/passwords#update
#                                POST   /users/password(.:format)                                                                devise/passwords#create
#       cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#          new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#         edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#              user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                PUT    /users(.:format)                                                                         devise/registrations#update
#                                DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                POST   /users(.:format)                                                                         devise/registrations#create
#               theme_idea_likes POST   /themes/:theme_id/ideas/:idea_id/likes(.:format)                                         themes/ideas/likes#create
#                theme_idea_like DELETE /themes/:theme_id/ideas/:idea_id/likes/:id(.:format)                                     themes/ideas/likes#destroy
#                    theme_ideas POST   /themes/:theme_id/ideas(.:format)                                                        themes/ideas#create
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
#             rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#      rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#             rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#      update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#           rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  resources :themes, only: %i[index show new create edit update] do
    resources :ideas, only: %i[create], module: 'themes' do
      resources :likes, only: %i[create destroy], module: 'ideas'
    end
    resources :tags, only: %i[create destroy], module: 'themes'
  end

  resources :dashboard, only: :index

  namespace :admin do
    devise_for :users, controllers: {
      sessions: 'admin/users/sessions',
      passwords: 'admin/users/passwords',
    }
  end


  root to: 'themes#index'
end
