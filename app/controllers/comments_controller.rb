class CommentsController < ApplicationController
	before_filter :authenticate_account!

	def create
		@comment = Comment.new(params[:comment])
		@comment.post_id = params[:comment][:post]
    	@comment.account = current_account
   		@success = @comment.save!
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
end