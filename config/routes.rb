Code4::Application.routes.draw do


  devise_for :accounts

  resources :accounts

  #后台路由
  namespace :cpanel do
    root :to => 'posts#index'
    resources :categories do
      collection do
        get :autocomplete
      end   
    end
    resources :tags do
      collection do
        get :autocomplete
      end
    end
    resources :posts
    resources :accounts
  end
  
  root :to => 'home#index'
  resources :posts do
    collection do
      get :get_book
    end    
  end

  resources :tags do
      collection do
        get :autocomplete
      end
  end


end
