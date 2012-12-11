# coding: UTF-8
class Cpanel::UsersController < Cpanel::ApplicationController


  def export
    
  end

  def upload_avatar
    @users = User.all
    @users.each do |user|
       gravatar_id = Digest::MD5.hexdigest(user.email.downcase) 
        if user.avatar_url == 'http://image.ibookwish.com/blank.png'
          user.remote_avatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.jpeg"
          user.save
        end
    end
    
  end

  def invite
    @users = User.where(:name => nil)
    @users.each do |user| 
     User.invite!(:email => user.email)
    end
    redirect_to  "/cpanel/users", notice: '操作成功.' 
  end


  def index
    @users = User.desc('_id').page(params[:page])
    @count = User.count
    respond_to do |format|
      format.html # index.html.erb
      format.json
      format.csv { send_data User.all.to_csv}
    end
  end

  def show
    @user = User.find_by(name: params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @user = User.find_by(name: params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(cpanel_users_path, :notice => 'User 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(cpanel_users_path, :notice => 'User 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_users_path,:notice => "删除成功。") }
      format.json
    end
  end
end
