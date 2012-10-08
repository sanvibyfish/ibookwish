#coding: utf-8
class Cpanel::PostsController < Cpanel::ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.desc(:created_at).page(params[:page]).per(10)
    drop_breadcrumb("Posts", cpanel_posts_path)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    drop_breadcrumb("Posts", cpanel_posts_path)
    drop_breadcrumb(@post.title)
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @categories = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    drop_breadcrumb("Posts", cpanel_posts_path)
    drop_breadcrumb(@post.title)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    #FIXME 修改未float
    params[:post][:coordinates] = params[:post][:coordinates].split(",")
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [:cpanel,@post], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
