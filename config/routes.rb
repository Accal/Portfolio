Rails.application.routes.draw do
  root to: 'pages#home'

  resources :portfolios, except: [:show, :destroy]
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'
  delete 'portfolio/:id', to: 'portfolios#destroy', as: 'portfolio_destroy'


  resources :blogs do
    member do
      get :toggle_status
    end
  end

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'

end
