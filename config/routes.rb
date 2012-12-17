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
    resources :users do
      collection do
        get :invite
        get :upload_avatar
      end
    end
    resources :notifications 
    resources :comments
    resources :apply_for_tests do
      member do
        get :invite
      end
      collection do
        get :invited
      end
    end
  end

  root :to => 'post#index'
  match "/about" , :to => 'posts#about'

  devise_for :users,  :controllers => {
      :registrations => :accounts,
      :invitations => :invitations,
      :passwords => :passwords
  } 



  resources :tags do
      collection do
        get :autocomplete
      end
  end

  resources :comments
  resources :notifications do
    collection do
      get :at 
      get :system
      get :private
    end
  end
  
  resources :users do
    member do
      post :follow
      post :unfollow
      get  :followers
      get  :following
      get  :join_posts
      get  :complete_posts
      get :near_me
    end
    collection do
      post :location_create
      get :near_me
      get :iwant_user
      post :iwant_user_save
      post :send_private_message
    end
  end

  resources :posts do
    collection do
      get :get_book
      get :get_posts
      get :feedback
    end    
    member do
      get :near_me
      get :tag
      post :complete_wish
      post :exec_user
      post :end_task
    end
  end

end
