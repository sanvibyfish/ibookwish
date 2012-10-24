Code4::Application.routes.draw do

  # #后台路由
  # namespace :cpanel do
  #   root :to => 'posts#index'
  #   resources :categories do
  #     collection do
  #       get :autocomplete
  #     end   
  #   end
  #   resources :tags do
  #     collection do
  #       get :autocomplete
  #     end
  #   end
  #   resources :posts
  # end

  mount Homeland::Engine, :at => "/bbs"
  
  root :to => 'posts#index'
  resources :posts do
    collection do
      get :get_book
      get :get_posts
    end    
    member do
      get :near_me
      get :tag
      post :complete_wish
      post :exec_user
      post :end_task
    end
  end


  devise_for :users,  :controllers => {
      :registrations => :accounts
  } 

  resources :tags do
      collection do
        get :autocomplete
      end
  end

  resources :comments
  resources :notifications
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
      get :near_me
      get :iwant_user
      post :iwant_user_save
    end
  end



end
