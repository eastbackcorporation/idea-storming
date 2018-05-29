# frozen_string_literal: true

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#               theme_ideas POST   /themes/:theme_id/ideas(.:format)                                                        themes/ideas#create
#                theme_tags POST   /themes/:theme_id/tags(.:format)                                                         themes/tags#create
#                 theme_tag DELETE /themes/:theme_id/tags/:id(.:format)                                                     themes/tags#destroy
#                    themes GET    /themes(.:format)                                                                        themes#index
#                           POST   /themes(.:format)                                                                        themes#create
#                 new_theme GET    /themes/new(.:format)                                                                    themes#new
#                edit_theme GET    /themes/:id/edit(.:format)                                                               themes#edit
#                     theme GET    /themes/:id(.:format)                                                                    themes#show
#                           PATCH  /themes/:id(.:format)                                                                    themes#update
#                           PUT    /themes/:id(.:format)                                                                    themes#update
#           dashboard_index GET    /dashboard(.:format)                                                                     dashboard#index
#                      root GET    /                                                                                        top#index
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users

  resources :themes, only: %i[index show new create edit update] do
    resources :ideas, only: %i[create], module: 'themes'
    resources :tags, only: %i[create destroy], module: 'themes'
  end

  resources :dashboard, only: :index

  root to: 'top#index'
end
