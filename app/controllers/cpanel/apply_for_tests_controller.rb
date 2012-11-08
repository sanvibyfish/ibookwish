# coding: UTF-8
class Cpanel::ApplyForTestsController < Cpanel::ApplicationController


  def invite
    @apply_for_test = ApplyForTest.find(params[:id])
    user = User.invite!(:email => @apply_for_test.email , :name => @apply_for_test.name,
      :location => session[:location])
    @apply_for_test.state = ApplyForTest::STATE[:sent]
    @apply_for_test.save
    # user.location = session[:location] 
    redirect_to  "/cpanel/apply_for_tests", notice: '操作成功.' 
  end

  def index
    @apply_for_tests = ApplyForTest.desc('_id').page(params[:page])
    @count = ApplyForTest.count
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @apply_for_test = ApplyForTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @apply_for_test = ApplyForTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @apply_for_test = ApplyForTest.find(params[:id])
  end

  def create
    @apply_for_test = ApplyForTest.new(params[:apply_for_test])

    respond_to do |format|
      if @apply_for_test.save
        format.html { redirect_to(cpanel_apply_for_tests_path, :notice => 'Apply for test 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @apply_for_test = ApplyForTest.find(params[:id])

    respond_to do |format|
      if @apply_for_test.update_attributes(params[:apply_for_test])
        format.html { redirect_to(cpanel_apply_for_tests_path, :notice => 'Apply for test 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @apply_for_test = ApplyForTest.find(params[:id])
    @apply_for_test.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_apply_for_tests_path,:notice => "删除成功。") }
      format.json
    end
  end
end
