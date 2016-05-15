Rails.application.routes.draw do
  scope(:module => 'auth') do
    root to: 'sessions#new'
    resources :sessions, only: [:new, :create, :delete]
  end

  # for signed in users
  scope(:module => 'private') do
    resource :welcome, only: [:show]
  end
end
