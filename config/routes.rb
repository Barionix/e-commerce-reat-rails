Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do 
    namespace :v1 do 
      post '/users/createAdminUser', to: "users#createAdmin"
      resources :users 

      post '/produtos/createProduct', to: "produtos#createProduct"
      get '/produtos/listarProdutos', to: "produtos#listProducts"
      resources :produtos do
        member do
          post 'editarProduto', to: 'produtos#productUpdate'
          get 'getProductByID', to: 'produtos#getProductByID'
        end
      end
    end 
  end 
  get "up" => "rails/health#show", as: :rails_health_check

end
