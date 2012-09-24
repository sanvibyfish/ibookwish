class TagsController < ApplicationController

	def autocomplete
		tags = Tag.autocomplete_data(params[:q])
		respond_to do |format|
			format.json { render :json => tags }
		end
	end

	  # GET /posts/1
  # GET /posts/1.json
  def show
    @tag = Tag.find_by(name: params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end
end
