Rails.application.routes.draw do
  resources :services, :cars

  resources :vouchers,  only: [:index, :show, :new, :create]

  devise_for :businesses, path: 'businesses', controllers: {
    sessions: "businesses/sessions",
    registrations: "businesses/registrations"
  }

  devise_for :customers, path: 'customers', controllers: { 
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }

  resources :businesses do
    resources :schedules, only: [:new, :create]
  end

  get 'index/index'
  get 'index/login'
  get 'index/signup'
  get 'index/about'
  get 'cep/index'
  get 'schedules/business_show'
  get 'schedules/customer_show'
  get 'reports/top10'


  devise_scope :customer do
    get 'sign_in', to: 'devise/sessions#new'
  end

  root to: "index#index"
end
