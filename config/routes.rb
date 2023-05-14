# Rails.application.routes.draw do
#   resources :comments
#   resources :likes
#   resources :posts
#   resources :users

#   # resources :posts do
#   #   resources :comments
#   # end

#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
#   get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
#   # get '/users/:user_id/posts/:post_id
#   get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
#   get '/comments', to: 'comments#index' , as: 'comentari'
 
  
#   root 'users#index'

# end

Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end