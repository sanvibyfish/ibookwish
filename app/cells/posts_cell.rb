class PostsCell < Cell::Rails
  include Devise::Controllers::Helpers
	helper :application, :accounts, :posts
  helper_method :current_user
  cache :index, :expires_in => 1.minutes

  def index(opts = {})
  	@current_tag     = opts[:current_tag]
  	@posts = opts[:posts]
  	@action_name = opts[:action_name]
  	render
  end

  def join(opts = {})
  	@post = opts[:post]
  	render
  end

  def complete(opts = {})
    @post = opts[:post]
    @task = opts[:task]
    render
  end


end
