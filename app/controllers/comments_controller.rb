class CommentsController < ApplicationController

	def create
		@comment = Comment.new(params[:comment])

		@comment.post_id = params[:comment][:post]
    	@comment.user = current_user
   		@success = @comment.save!
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
end