#coding:utf-8
class Cpanel::ApplyForTestsController < Cpanel::ApplicationController

  # GET /categories
  # GET /categories.json
  def index
    @apply_for_tests = ApplyForTest.all.desc(:created_at).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apply_for_tests }
    end
  end


  def invite
    @apply_for_test = ApplyForTest.find(params[:id])
    User.invite!(:email => @apply_for_test.email , :name => @apply_for_test.name)
    @apply_for_test.state = ApplyForTest::STATE[:sent]
    @apply_for_test.save
    redirect_to  "/cpanel/apply_for_tests", notice: '操作成功.' 
  end


  def invited
    @user = User.invite!(:email => "", :skip_invitation => true)
    redirect_to  "/cpanel/apply_for_tests", notice: "http://www.ibookwish.com:3000/users/invitation/accept?invitation_token=#{@user.invitation_token}" 
  end
end
