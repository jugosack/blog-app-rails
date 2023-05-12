Rails.application.routes.draw do
  resources :comments
  resources :likes
  resources :posts
  resources :users

  # resources :users do
  #   resources :posts
  # end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  # get '/users/:user_id/posts/:post_id
  get   '/users/:user_id/posts/:id', to: 'posts#show' , as: 'user_post'
  root 'users#index'
end
