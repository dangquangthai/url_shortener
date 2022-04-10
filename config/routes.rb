Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'links#index'
  resources :links
  get ':token' => 'shorten#index', as: :shorten

  scope :api, as: :api, module: :api do
    scope :v1, as: :v1, module: :v1 do
      resources :links, only: %i[index create]
    end
  end
end
