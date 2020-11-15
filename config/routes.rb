Rails.application.routes.draw do
  resources :users, except: %i(index) do
    post '/follow', to: 'users#follow', on: :collection
    post '/unfollow', to: 'users#unfollow', on: :collection
    get '/followers', to: 'users#followers', on: :collection
    get '/followeds', to: 'users#followeds', on: :collection
  end

  resources :posts, except: %i(index)
end
