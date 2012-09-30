class UsersController < ApplicationController

	def show
		@account = Account.find_by(:nickname => params[:id])
		@share_count = @account.posts.count
		@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
 	end
end
