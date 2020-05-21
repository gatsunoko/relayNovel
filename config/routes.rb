Rails.application.routes.draw do
  root 'novel_lists#index'
  resources :novel_lists
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    sessions: "users/sessions",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, :only => [:show, :edit, :update]
  resources :novels do
    member do
      get :selected
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
