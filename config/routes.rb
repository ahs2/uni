require 'sidekiq/web'
require 'sidekiq-scheduler/web'

class SubdomainConstraint   
  def self.matches?(request)     
    request.subdomain.present? && (request.subdomain != 'www' || request.subdomain != 'university-sgi')
  end 
end

Rails.application.routes.draw do
  resources :etudiants
  root 'home#welcome'

  scope 'auth' do
    devise_for :users, controllers: {
      sessions: 'user/sessions',
      registrations: 'user/registrations',
      confirmations: 'user/confirmations',
      invitations: 'user/invitations',
      passwords: "users/passwords",
    }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  end

  devise_scope :user do
    get '/profile', to: 'user/registrations#edit'
    put '/profile', to: 'user/registrations#update'
    post '/edit-password' => 'user/registration#update', as: 'profile_password'
    post 'auth/register', to: 'user/registrations#create'
  end

  authenticate :user, lambda { |u| Rails.env.development? || u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  constraints SubdomainConstraint do
    resource :pre_registration, only: [:show] do 
      member do 
        get :success
      end
    end
    resources :transactions
    resources :students
    resources :fields
    resources :field_options
    resources :import_students

  end
  
  resource :dashboard, only: [:show]
  resources :users do
    member do
      post :impersonate
    end
    collection do
      delete :unimpersonate
    end
  end
  resources :universities
  resources :school_years
  resource :settings, only: [:show]
end
