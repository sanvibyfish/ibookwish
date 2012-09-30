class PostsCell < Cell::Rails
	helper :application, :accounts
  def menu_posts
    render
  end

  def index(opts = {})
  	@current_tag     = opts[:current_tag]
  	@posts = opts[:posts]
  	@action_name = opts[:action_name]
  	render
  end

end
