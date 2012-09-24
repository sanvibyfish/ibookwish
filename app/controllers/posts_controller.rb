#coding: utf-8
require "open-uri"  

class PostsController < ApplicationController
	before_filter :authenticate_account!, :only => [:new, :create]
	before_filter :location, :only => [:index, :near_me]

	DOUBAN_APIKEY = '0c4c24c38128d4df24e46e4a837a7e9d'
	DOUBAN_SECRET = 'd66f4058142d5c92'
	DOUBAN_ACCESS_TOKEN = '1bfe1241d8bdf5de53fa36c58a39e19a'
	def new	
		@post = Post.new
	end

	def location
		@locations = Location.all
		# FIXME 目前是虚拟IP
		request.env["HTTP_X_FORWARDED_FOR"] = "58.251.231.75"
		@location = Location.find_by(pin_yin: request.location.city.downcase)
	end

	def get_book
		@book = JSON.parse(open("http://api.douban.com/v2/book/isbn/#{params[:isbn]}?apikey=#{DOUBAN_APIKEY}&secret=#{DOUBAN_SECRET}").read)
		@tags = []
		@book["tags"].each { |tag|
			@tags << tag["name"]
		}
		@sucess = true if @book
		respond_to do |format|
			format.js { render :layout => false }
		end
	end

	def get_posts
		@posts = Post.desc(:created_at).page(params[:page])
		render "posts/_posts"
	end

	def index
		@posts = Post.desc(:created_at).page(params[:page])
	end

	def near_me
		@posts = Post.where(city: params[:id]).desc(:created_at).page(params[:page])
	end


	def create
		# FIXME: 跳转修复
		params[:post][:coordinates] = [params[:lat],params[:lng]]
		@result = JSON.parse(open("http://maps.google.cn/maps/geo?output=json&hl=zh_cn&q=#{params[:lat]},#{params[:lng]}").read)
		params[:post][:address] = @result["Placemark"][0]["address"]
		params[:post][:city] = @result["Placemark"][0]["AddressDetails"]["Locality"]["LocalityName"]
		params[:post][:state] = @result["Placemark"][0]["AddressDetails"]["Locality"]["AddressLine"]
		@post = Post.new(params[:post])
		@post.account = current_account
		if @post.save
			redirect_to @post, notice: '操作成功.' 
		else
			render action: "new" 
		end
	end



	def show

	end


end
