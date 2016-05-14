Rails.application.routes.draw do
  scope(:module => 'auth') do
    root to: 'sessions#new'
    resources :sessions, only: [:new, :create, :delete]
  end
end
