require "open-uri"  

class PostsController < ApplicationController
	DOUBAN_APIKEY = '0c4c24c38128d4df24e46e4a837a7e9d'
	DOUBAN_SECRET = 'd66f4058142d5c92'
	DOUBAN_ACCESS_TOKEN = '1bfe1241d8bdf5de53fa36c58a39e19a'
	def new	
		@post = Post.new
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

	def create
		# FIXME: 已经保存,未添加验证
		@post = Post.new(params[:post])
		@sucess if @post.save

	end


end
