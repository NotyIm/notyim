Rails.application.routes.draw do
  resources :notifications
  resources :charges
  resources :verification, only: [:show, :create] do
    member do
      get 'verify'
      post 'resend'
      match 'interactive_voice', via: [:get, :post]
    end
  end

  resources :checks
  resources :assertions, only: [:create, :edit, :update, :destroy]
  resources :incidents, only: [:index, :show]
  resources :incident_voices, only: [:show]

  resources :receivers
  post '/incident_receivers/:check_id', to: 'incident_receivers#create', as: :register_incident_receivers

  resources :teams
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #devise_for :users
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }

  require 'sidekiq/web'
  authenticate :user, -> (u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'home#index'

  get '/terms', to: 'page#term', as: 'show_term'
  get '/privacy', to: 'page#privacy', as: 'show_privacy'
  get '/faq', to: 'page#faq', as: 'show_faq'
  get '/feedbacks', to: 'page#feedback', as: 'show_feedback'
  get '/about', to: 'page#about', as: 'show_about'
  get '/changelog', to: 'page#changelog', as: 'show_changelog'

  get '/docs', to: 'page#doc', as: 'show_doc'
  get '/dashboard', to: 'checks#index', as: 'user_root'

  namespace :users do
    get '/plans', to: 'plans#show', as: 'show_plans'
    get '/billing', to: 'billing#show', as: 'show_billings'
    get '/api_tokens', to: 'api#index', as: 'api_tokens'
  end

  namespace :api do
    namespace :bot do
      resources :registrations, only: [:create]
      get '/me', to: 'me#show', as: 'show_me'
      resources :checks, only: [:index, :show, :create, :destroy]
      get '/link_verification/:user_id/:bot_id', to: 'verification#link', as: 'link_verification'
    end
  end

  scope :status_page, module: 'status_page' do
    get '/status_page/:id', to: 'checks#show', as: 'show_status_page'
  end
end
