Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      post "/auth/login", to: "auth#login"
      resources :auth

      post "/caixa/cadastrarMovimentacao", to: "caixa#cadastrarMovimentacao"
      get "/caixa/listarMovimentacoes", to: "caixa#listarMovimentacoes"
      get "/caixa/obterCaixa", to: "caixa#obterCaixa"
      resources :caixa  do 
        member do 
          delete 'deletarMovimentacao', to: "caixa#deletarMovimentacao"
          post 'editarMovimentacao', to: "caixa#editarMovimentacao"
        end 
      end

      post "/cupons/cadastrarCupom", to: "cupons#cadastrarCupom"
      get "/cupons/listarCupons", to: "cupons#listarCupons"
      resources :cupons  do 
        member do 
          get 'validarCupom', to: "cupons#validarCupom"
        end 
      end

      post '/sales/confirmSale', to: "sales#confirmSale"
      resources :sales 

      post '/users/createAdminUser', to: "users#createAdmin"
      resources :users 

      post '/sharts/publishChart', to: "sharts#publishChart"
      resources :sharts  do 
        member do 
          get 'getChartByID', to: "sharts#getChartByID"
        end 
      end

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
