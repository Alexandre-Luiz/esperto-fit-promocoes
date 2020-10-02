Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :partner_companies, only: [:index, :show, :new, :create] do
    resources :partner_company_employees, only: [:index, :new, :create]
  end

end

