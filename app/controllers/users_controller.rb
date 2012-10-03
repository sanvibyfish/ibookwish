class UsersController < ApplicationController

	def show
		@account = Account.find_by(:nickname => params[:id])
		@share_count = @account.posts.count
		@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
    @action_name = "show"
 	end

 	def follow
      @account = Account.find(params[:id])
    	@account.push_follower(current_account.id)
    	render :text => "1"
  	end

  	def unfollow
    	@account = Topic.find(params[:id])
    	@account.pull_follower(current_account.id)
   		render :text => "1"
  	end
end
