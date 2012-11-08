#coding: utf-8
class UserMailer < ActionMailer::Base
  include Resque::Mailer
  default from: Setting.from_send

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.remind.subject
  #
  def remind_private(notification,mail,subject,avatar, body, from_user_name, created_at)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    
    mail(:to => mail, :subject => subject )
  end


  def remind_at(notification,mail,subject,avatar, body, from_user_name, created_at)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    
    mail(:to => mail, :subject => subject )
  end

  def remind_reply(notification,mail,subject,avatar, body, from_user_name, created_at, post_id, post_title)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    @post_id = post_id
    @post_title = post_title
    mail(:to => mail, :subject => subject )
  end

  def remind_system(notification,mail,subject,avatar, body, from_user_name, created_at, post_id, post_title)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    @post_id = post_id
    @post_title = post_title
    mail(:to => mail, :subject => subject )
  end

end
