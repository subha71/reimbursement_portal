Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get '/auth/:provider/callback', to: 'sessions#create'  # Callback for Google OAuth
  get '/logout', to: 'sessions#destroy', as: :logout 
  get '/auth/failure', to: redirect('/')   # Logout route
  root 'users#home' 
  resources :companies
  resources :employees
  resources :employees do
    resources :reimbursements, only: [:new, :create]
  end
  resources :reimbursements, only: [:index, :show, :edit, :update, :destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end
