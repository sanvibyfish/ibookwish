#coding = utf-8
class UsersController < ApplicationController
  before_filter :location, :only => [:near_me]
  before_filter :set_menu_active
  skip_before_filter :authenticate_user!, :only => [:iwant_user, :iwant_user_save]
  layout "coming_soon", :only => [:iwant_user, :iwant_user_save]

  def location_create
    current_user.coordinates = [Float(params[:lat]),Float(params[:lng])] 
    current_user.address = params[:address]
    current_user.location = Location.where(name: params[:city][0,2]).first
    @success = true
    if current_user.location.blank?
      @message = '暂时不支持该城市！更多城市会在公测后开放' 
      @success = false
    end
    if @success
      current_user.save
      @post = Post.new
    end

    respond_to do |format|
      format.js { render :layout => false }
      return
    end
  end

	def show
		@user = User.where(:name => params[:id]).first
    unless @user
      render_404
      return
    end
		@posts = Post.where(:user => @user).desc(:created_at).page(params[:page])
    @action_name = "show"
    set_seo_meta(@user.name)
    render  :action => "index"
 	end

 	def follow
      @user = User.find(params[:id])
      current_user.push_following(params[:id])
    	@user.push_follower(current_user.id)
      set_seo_meta(@user.name)
    	render :text => "1"
  end

  def unfollow
    	@user = User.find(params[:id])
      current_user.pull_following(params[:id])
    	@user.pull_follower(current_user.id)
      set_seo_meta(@user.name)
   		render :text => "1"
  end

  def index

  end

  def followers
    @user = User.find_by(:name => params[:id])
    @users = @user.followers.desc(:created_at).page(params[:page]).per(10)
    set_seo_meta(@user.name)
    render  :action => "index"
  end

  def following
    @user = User.find_by(:name => params[:id])
    @users = @user.following.desc(:created_at).page(params[:page]).per(10)
    set_seo_meta(@user.name)
    render :action => "index"
  end

  def join_posts
    @user = User.find_by(:name => params[:id])
    @posts = @user.wish_posts.desc(:created_at).page(params[:page])
    set_seo_meta(@user.name)
    render :action => "index"
  end

  def complete_posts
    @user = User.find_by(:name => params[:id])
    @posts = @user.complete_posts.desc(:created_at).page(params[:page])
    set_seo_meta(@user.name)
    render :action => "index"
  end

  def near_me 
    unless params[:id].blank?
      session[:location] = Location.find_by(name: params[:id])
    end

    if  session[:gender].blank?
      session[:gender] = 1
    elsif params[:gender].blank?
      session[:gender] = 1
    else
       session[:gender] = params[:gender]
    end
    @users = User.where(location: session[:location], gender: session[:gender]).desc(:created_at).page(params[:page]).per(12)
    render :action => "friends"
  end

  def iwant_user

    @apply_for_test = ApplyForTest.new
  end

  def iwant_user_save
    user = User.where(:email => params[:apply_for_test][:email]).first
    # user = User.where(:email => params[:apply_for_test][:email]).and(:name.exists => true).first
    unless user.blank?
      if user.name.blank?
        User.invite!(:email => params[:apply_for_test][:email])
        redirect_to "/users/iwant_user" , alert: '你已经申请过内测了，我们将重新发送邀请邮件给你，请检查邮箱' 
        return
      else
        redirect_to "/users/iwant_user", alert: '不乖哦，你已经注册过账号了.' 
        return
      end
    end
    @apply_for_test = ApplyForTest.new(params[:apply_for_test])
    if @apply_for_test.save
      redirect_to "/users/iwant_user", notice: '你的申请已经成功，在验证信息后我们会发送一封邮件邀请你注册.' 
    else
      render :action => :iwant_user , alert: '申请失败' 
    end
  end


  def send_private_message
    @notif =  Notification.create :from_user => current_user.id, :to_user => params[:complete_user_id], :body => params[:message], 
    :notif_type => Notification::TYPE[:private]
    @notif.from_user.send_ids.push(@notif.id)
    @notif.to_user.notification_ids.push(@notif.id)

    respond_to do |format|
      format.js { render :layout => false }
    end

  end

  protected

    def set_menu_active
      @current = @current = ['/users/near_me']
    end



end
