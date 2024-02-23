Rails.application.routes.draw do
  resources :posts
  get 'about', to: 'pages#about'
  get 'posts', to: 'posts#show'

  root "pages#home"

end
