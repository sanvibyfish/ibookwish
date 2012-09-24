class Cpanel::TagsController < Cpanel::ApplicationController

	def autocomplete
		tags = Tag.autocomplete_data(params[:q])
		respond_to do |format|
			format.json { render :json => tags }
		end
	end
end
