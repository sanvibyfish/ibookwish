class UsersController < ApplicationController
  before_filter :location, :only => [:near_me]
  before_filter :set_menu_active

	def show
		@account = Account.find_by(:nickname => params[:id])
		@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
    @action_name = "show"
    render  :action => "index"
 	end

 	def follow
      @account = Account.find(params[:id])
      current_account.push_following(params[:id])
    	@account.push_follower(current_account.id)
    	render :text => "1"
  end

  def unfollow
    	@account = Account.find(params[:id])
      current_account.pull_following(params[:id])
    	@account.pull_follower(current_account.id)
   		render :text => "1"
  end

  def index

  end

  def followers
    @account = Account.find_by(:nickname => params[:id])
    render  :action => "index"
  end

  def following
    @account = Account.find_by(:nickname => params[:id])
    render :action => "index"
  end


  def near_me 
    unless params[:id].blank?
      session[:location] = Location.find_by(name: params[:id])
    end

    if  session[:gender].blank?
      session[:gender] = 1
    elsif params[:gender].blank?
      session[:gender] = 1
    else
       session[:gender] = params[:gender]
    end
    @accounts = Account.where(location: session[:location], gender: session[:gender]).desc(:created_at).page(params[:page])

    render :action => "friends"
  end


  protected

    def set_menu_active
      @current = @current = ['/users/near_me']
    end



end
