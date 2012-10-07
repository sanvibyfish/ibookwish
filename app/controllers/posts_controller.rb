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

	def location
		@locations = Location.all
		if session[:location].blank?
			# FIXME 目前是虚拟IP
			if request.location.city.downcase.blank?
				session[:location] =  Location.find_by(pin_yin: "shenzhen")
			else
				session[:location] = Location.find_by(pin_yin: request.location.city.downcase)
			end
			
		end
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
			params[:post][:coordinates] = [params[:lat],params[:lng]]
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
		@comment = Comment.new
		#FIXME 寻找周边图书
	end


	protected

  	def set_menu_active
    	@current = @current = ['/posts']
  	end



end
