#coding = utf-8
class UsersController < ApplicationController
  before_filter :location, :only => [:near_me]
  before_filter :set_menu_active
  skip_before_filter :authenticate_account!, :only => [:iwant_account]

	def show
		@account = Account.find_by(:nickname => params[:id])
		@posts = Post.where(:account => @account).desc(:created_at).page(params[:page])
    @action_name = "show"
    render  :action => "index"
 	end

 	def follow
      @account = Account.find(params[:id])
      current_account.push_following(params[:id])
    	@account.push_follower(current_account.id)
    	render :text => "1"
  end

  def unfollow
    	@account = Account.find(params[:id])
      current_account.pull_following(params[:id])
    	@account.pull_follower(current_account.id)
   		render :text => "1"
  end

  def index

  end

  def followers
    @account = Account.find_by(:nickname => params[:id])
    render  :action => "index"
  end

  def following
    @account = Account.find_by(:nickname => params[:id])
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
    @accounts = Account.where(location: session[:location], gender: session[:gender]).desc(:created_at).page(params[:page])

    render :action => "friends"
  end

  def iwant_account
    @apply_for_test = ApplyForTest.new
  end

  def iwant_account_save
    @apply_for_test = ApplyForTest.new(params[:apply_for_test])
    if @apply_for_test.save
      redirect_to "/users/iwant_account", notice: '你的申请已经成功，在验证信息后我们会发送一封邮件邀请你注册.' 
    else
      render :action => :iwant_account , error: '申请失败' 
    end
  end

  protected

    def set_menu_active
      @current = @current = ['/users/near_me']
    end



end
