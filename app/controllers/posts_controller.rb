#coding: utf-8
require "open-uri"  
class PostsController < ApplicationController
	before_filter :location, :only => [:index, :near_me, :tag]
	before_filter :set_menu_active
	
	skip_before_filter :set_menu_active, :only => [:feedback]

	DOUBAN_APIKEY = '083ef65be9c7ffc118bce313bd57ff43'
	DOUBAN_SECRET = '7279c80feb82faae'
	DOUBAN_ACCESS_TOKEN = '1bfe1241d8bdf5de53fa36c58a39e19a'

	def new	
		@post = Post.new
		@step = 1
		set_seo_meta("借出图书")
		render :layout => false
	end

	def feedback
		
	end


	def get_book
		unless params[:isbn] =~ /^[1-9]\d*$/
			@sucess = false	
			@message = "你输入的数据有问题，请输入例如97875404449131这样个ISBN格式"
			respond_to do |format|
				format.js { render :layout => false }
			end
			return
		end
		@book = JSON.parse(open("http://api.douban.com/v2/book/isbn/#{params[:isbn]}?apikey=#{DOUBAN_APIKEY}&secret=#{DOUBAN_SECRET}").read)
		@post = Post.new
		@book["isbn"] = params[:isbn]
		@sucess = true
		respond_to do |format|
			format.js { render :layout => false }
			return
		end
		rescue OpenURI::HTTPError, Net::HTTPNotFound
		@sucess = false	

		@message = "找不到该书，请查看ISBN是否正确"
		respond_to do |format|
			format.js { render :layout => false }
			return
		end
	end

	def get_posts
		if params[:action_name] == "near_me"
			@posts = Post.where(location: session[:location]).desc(:created_at).page(params[:page])
			@action_name = "near_me"
		elsif params[:action_name] == "tag"
			@current_tag = Tag.find_by(:name => params[:id])
			@posts = @current_tag.posts.desc(:created_at).page(params[:page])
			@action_name = "tag"
		elsif params[:action_name] == "show"
			@account = User.find_by(:name => params[:id])
			@share_count = @account.posts.count
			@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
			@action_name = "show"
		else
			@posts = Post.desc(:created_at).page(params[:page])
			@action_name = "index"

		end
	end

	def index
		set_seo_meta("用书本来连接每个人")
		@posts = Post.desc(:created_at).page(params[:page])
	end

	def near_me
		session[:location] = Location.find_by(name: params[:id])
		@posts = Post.where(location: session[:location]).desc(:created_at).page(params[:page])
		set_seo_meta("同城")
		render :action => "index"
	end

	def tag
		@current_tag = Tag.where(:name => params[:id]).first
		if @current_tag.blank?
			render_404
			return
		end
		@posts = @current_tag.posts.desc(:created_at).page(params[:page])
		set_seo_meta(@current_tag.name)
		render :action => "index"
	end


	def create 
		params[:post][:coordinates] = current_user.coordinates
		params[:post][:address] = current_user.address
		params[:post][:location] = current_user.location
		@post = Post.new(params[:post])
		@post.remote_image_url = params[:post][:image]
		@post.user = current_user
		if  @post.save
			@sucess = true
		else
			@sucess = false
		end
	    respond_to do |format|
	      format.js { render :layout => false }
	      return
	    end
	end



	def show
		@post = Post.where(:id => params[:id]).first
		if @post.blank?
			render_404
			return
		end
		@post.hits.incr(1)
		@comment = Comment.new
		set_seo_meta(@post.title)
		@think_like_books = Post.where(:user => @post.user).desc(:created_at).limit(5)
	end

	def complete_wish
		@post = Post.find(params[:id])
		if @post.push_wish_user(current_user.id)
			current_user.push_wish_post(@post.id)
			@post.send_notification(Notification::TYPE[:join],current_user, @post.user,"我刚申请了想要借你本书")
			redirect_to @post, notice: '操作成功.' 
		else
			redirect_to @post, alert: '已经添加过了' 
		end
	end

	def exec_user
		@post = Post.find(params[:id])
		if @post.complete_user?
			redirect_to @post, alert: '当前任务已经有人选了' 
		else
			@post.complete_user_id = params[:complete_user_id]
			@post.complete_user.push_complete_post(@post.id)
			@post.save
			@post.send_notification(Notification::TYPE[:complete_choose],@post.user,@post.complete_user,"我刚通过你的申请")
			redirect_to @post, notice: '操作成功.' 
		end		
	end

	def end_task
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			@post.send_notification(Notification::TYPE[:complete],@post.user,@post.complete_user,"我刚给你评价:#{@post.rating_body}")
			redirect_to @post, notice: '操作成功.' 
		else
			redirect_to @post, alert: '操作失败.' 
		end



	end

	def about
		
	end


	protected

  	def set_menu_active
    	@current = @current = ['/posts']
  	end



end
