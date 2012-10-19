#coding: utf-8
require "open-uri"  
class PostsController < ApplicationController
	before_filter :authenticate_account!
	before_filter :location, :only => [:index, :near_me, :tag]
	before_filter :set_menu_active

	DOUBAN_APIKEY = '0c4c24c38128d4df24e46e4a837a7e9d'
	DOUBAN_SECRET = 'd66f4058142d5c92'
	DOUBAN_ACCESS_TOKEN = '1bfe1241d8bdf5de53fa36c58a39e19a'

	def new	
		@post = Post.new
	end


	def get_book
		@book = JSON.parse(open("http://api.douban.com/v2/book/isbn/#{params[:isbn]}?apikey=#{DOUBAN_APIKEY}&secret=#{DOUBAN_SECRET}").read)
		@sucess = true
		respond_to do |format|
			format.js { render :layout => false }
		end
		rescue OpenURI::HTTPError, Net::HTTPNotFound, Mechanize::ResponseCodeError
		@sucess = false	
		respond_to do |format|
			format.js { render :layout => false }
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
			@account = Account.find_by(:nickname => params[:id])
			@share_count = @account.posts.count
			@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
			@action_name = "show"
		else
			@posts = Post.desc(:created_at).page(params[:page])
			@action_name = "index"
		end
	end

	def index
		@posts = Post.desc(:created_at).page(params[:page])
	end

	def near_me
		session[:location] = Location.find_by(name: params[:id])
		@posts = Post.where(location: session[:location]).desc(:created_at).page(params[:page])
		render :action => "index"
	end

	def tag
		@current_tag = Tag.find_by(:name => params[:id])
		@posts = @current_tag.posts.desc(:created_at).page(params[:page])
		render :action => "index"
	end


	def create
		# FIXME: 跳转修复 
		unless params[:lat].blank?
			params[:post][:coordinates] = [Float(params[:lat]),Float(params[:lng])]
			doc = JSON.parse(open("http://maps.google.cn/maps/geo?output=json&hl=zh_cn&q=#{params[:lat]},#{params[:lng]}").read)
			address_path = JsonPath.new('$..address')
			location_path = JsonPath.new('$..LocalityName')
			params[:post][:address] = address_path.on(doc).first
			params[:post][:location] = Location.find_by(name: location_path.on(doc).first[0,2]) 
		end
		@post = Post.new(params[:post])
		@post.remote_image_url = params[:post][:image]
		@post.account = current_account
		if @post.save
			redirect_to @post, notice: '操作成功.' 
		else
			render action: "new" 
		end
	end



	def show
		@post = Post.find(params[:id])
		@post.hits.incr(1)
		@comment = Comment.new
		@nears = Post.near(:coordinates => @post.coordinates).desc(:created_at).limit(10)
		# @comments = @post.comment.asc(:id).all.include?(@post.account) 
		# # 通知处理
  #     	unless current_account.post_read?(@post)
  #       current_account.notifications.unread.any_of({:mentionable_type => 'Reply', :mentionable_id.in => @comments.map(&:id)},
  #                                                {:reply_id.in => @comments.map(&:id)}).update_all(:read => true)
  #       current_user.read_post(@post)
      	# end
	end

	def complete_wish
		@post = Post.find(params[:id])
		if @post.push_wish_user(current_account.id)
			current_account.push_wish_post(@post.id)
			redirect_to @post, notice: '操作成功.' 
		else
			redirect_to @post, error: '已经添加过了' 
		end
	end

	def exec_user
		@post = Post.find(params[:id])
		if @post.complete_user?
			redirect_to @post, error: '当前任务已经有圆梦师了' 
		else
			@post.complete_user_id = params[:complete_user_id]
			@post.complete_user.push_complete_post(@post.id)
			@post.save
			redirect_to @post, notice: '操作成功.' 
		end		
	end

	def end_task
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			redirect_to @post, notice: '操作成功.' 
		else
			redirect_to @post, notice: '操作失败.' 
		end



	end



	protected

  	def set_menu_active
    	@current = @current = ['/posts']
  	end



end
