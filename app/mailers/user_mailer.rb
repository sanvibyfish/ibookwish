#coding: utf-8
class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  require "net/http"
  require "uri"
  default from: Setting.from_send
  layout 'mail'

  def confirmation_instructions(record)
    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record)
    @resource = record
    send_mail(:to => @resource.email, :subject => "[书愿网]重置你在书愿网的密码", :content => render(:reset_password_instructions))
  end

  def unlock_instructions(record)
    devise_mail(record, :unlock_instructions)
  end

  def invitation_instructions(record)
     @resource = record
     send_mail(:to => @resource.email, :subject => "[书愿网]邀请你参加内测", :content => render( :invitation_instructions))
  end

  def remind_private(notification,mail,subject,avatar, body, from_user_name, created_at)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    send_mail(:to => mail, :subject => subject, :content => render(:remind_private))
    return 
  end


  def remind_at(notification,mail,subject,avatar, body, from_user_name, created_at)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    send_mail(:to => mail, :subject => subject, :content => render(:remind_at))
    return
  end

  def remind_reply(notification,mail,subject,avatar, body, from_user_name, created_at, post_id, post_title)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    @post_id = post_id
    @post_title = post_title
    send_mail(:to => mail, :subject => subject, :content => render(:remind_reply))
    return
  end

  def remind_system(notification,mail,subject,avatar, body, from_user_name, created_at, post_id, post_title)
    @avatar = avatar
    @body = body
    @from_user_name = from_user_name 
    @created_at = created_at
    @post_id = post_id
    @post_title = post_title
    send_mail(:to => mail, :subject => subject, :content => render(:remind_system))
    return
  end

  def send_mail(opts={})
    uri = URI.parse(Setting.send_mail_url)
    response = Net::HTTP.post_form(uri, {"email[from]" => Setting.from_send, "email[to]" => opts[:to], 
      "email[subject]" => opts[:subject], "email[content]" => opts[:content], "email[is_html]" => true})  
    self.message.perform_deliveries = false
  end



end
