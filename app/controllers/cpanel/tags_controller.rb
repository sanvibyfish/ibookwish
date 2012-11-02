# coding: UTF-8
class Cpanel::TagsController < Cpanel::ApplicationController
  before_filter :set_menu_active

  def autocomplete
    tags = Tag.autocomplete_data(params[:q])
    respond_to do |format|
      format.json { render :json => tags }
    end
  end


  def index
    @tags = Tag.desc('_id').page(params[:page])
     @count = Tag.count
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to(cpanel_tags_path, :notice => 'Tag 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @tag = Tag.find_by(name: params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(cpanel_tags_path, :notice => 'Tag 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_tags_path,:notice => "删除成功。") }
      format.json
    end
  end


  protected

  def set_menu_active
    @current = @current = ['/cpanel/tags']
  end
end
