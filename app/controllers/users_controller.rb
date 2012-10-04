class UsersController < ApplicationController

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
end
