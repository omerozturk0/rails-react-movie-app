# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                               ratings GET    /ratings(.:format)                                                                       ratings#index
#                                       POST   /ratings(.:format)                                                                       ratings#create
#                            new_rating GET    /ratings/new(.:format)                                                                   ratings#new
#                           edit_rating GET    /ratings/:id/edit(.:format)                                                              ratings#edit
#                                rating GET    /ratings/:id(.:format)                                                                   ratings#show
#                                       PATCH  /ratings/:id(.:format)                                                                   ratings#update
#                                       PUT    /ratings/:id(.:format)                                                                   ratings#update
#                                       DELETE /ratings/:id(.:format)                                                                   ratings#destroy
#                            categories GET    /categories(.:format)                                                                    categories#index
#                                       POST   /categories(.:format)                                                                    categories#create
#                          new_category GET    /categories/new(.:format)                                                                categories#new
#                         edit_category GET    /categories/:id/edit(.:format)                                                           categories#edit
#                              category GET    /categories/:id(.:format)                                                                categories#show
#                                       PATCH  /categories/:id(.:format)                                                                categories#update
#                                       PUT    /categories/:id(.:format)                                                                categories#update
#                                       DELETE /categories/:id(.:format)                                                                categories#destroy
#                                movies GET    /movies(.:format)                                                                        movies#index
#                                       POST   /movies(.:format)                                                                        movies#create
#                             new_movie GET    /movies/new(.:format)                                                                    movies#new
#                            edit_movie GET    /movies/:id/edit(.:format)                                                               movies#edit
#                                 movie GET    /movies/:id(.:format)                                                                    movies#show
#                                       PATCH  /movies/:id(.:format)                                                                    movies#update
#                                       PUT    /movies/:id(.:format)                                                                    movies#update
#                                       DELETE /movies/:id(.:format)                                                                    movies#destroy
#                      new_user_session GET    /users/sign_in(.:format)                                                                 users/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 users/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                users/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            users/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           users/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                users/passwords#update
#                                       PUT    /users/password(.:format)                                                                users/passwords#update
#                                       POST   /users/password(.:format)                                                                users/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  users/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 users/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    users/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         users/registrations#update
#                                       PUT    /users(.:format)                                                                         users/registrations#update
#                                       DELETE /users(.:format)                                                                         users/registrations#destroy
#                                       POST   /users(.:format)                                                                         users/registrations#create
#                                  root GET    /                                                                                        movies#index
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  resources :ratings
  resources :categories
  resources :movies do
    collection do
      get :own
    end
  end

  devise_for :users, controllers: {
    confirmations:      'users/confirmations',
    passwords:          'users/passwords',
    registrations:      'users/registrations',
    sessions:           'users/sessions',
  }

  root to: "movies#index"
end
