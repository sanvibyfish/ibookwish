Code4::Application.routes.draw do

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
  
  root :to => 'posts#index'
  resources :posts do
    collection do
      get :get_book
      get :get_posts
    end    
    member do
      get :near_me
      get :tag
    end
  end

  devise_for :accounts,  :controllers => {
      :registrations => :accounts
  } 

  resources :tags do
      collection do
        get :autocomplete
      end
  end



  resources :accounts
  resources :users do
    member do
      post :follow
      post :unfollow
    end
  end

end
