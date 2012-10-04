class PostsCell < Cell::Rails
	helper :application, :accounts


  def index(opts = {})
  	@current_tag     = opts[:current_tag]
  	@posts = opts[:posts]
  	@action_name = opts[:action_name]
  	render
  end

end
