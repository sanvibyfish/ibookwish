# coding: UTF-8
class Cpanel::NotificationsController < Cpanel::ApplicationController

  def index
    @notifications = Notification.desc('_id').page(params[:page])
    @count = Notification.count
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to(cpanel_notifications_path, :notice => 'Notification 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to(cpanel_notifications_path, :notice => 'Notification 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_notifications_path,:notice => "删除成功。") }
      format.json
    end
  end
end
