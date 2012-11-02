# coding: UTF-8
class Cpanel::PostsController < Cpanel::ApplicationController

  def index
    @posts = Post.desc('_id').page(params[:page])
    @count = Post.count
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(cpanel_posts_path, :notice => 'Post 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(cpanel_posts_path, :notice => 'Post 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_posts_path,:notice => "删除成功。") }
      format.json
    end
  end
end
