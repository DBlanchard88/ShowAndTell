Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/u/:id', to: 'users#profile', as: 'user'

  # /posts/1/comments/4
  resources :posts do
    resources :comments
  end

  get 'about', to: 'pages#about'

  # root path
  root "pages#home"

end
