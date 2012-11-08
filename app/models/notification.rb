#coding:utf-8
class Notification
  include Mongoid::Document
  include Mongoid::Timestamps


	belongs_to  :from_user, :class_name => "User", :inverse_of => :sends
	belongs_to	:to_user, :class_name => "User", :inverse_of => :notifications
	field :body
	belongs_to :post
	field :read, :default => false
	validates_presence_of  :body
	field :notif_type, :type => Integer, :default => 0 
	
	scope :unread, where(:read => false)
	
	TYPE = {
		:reply => 0,
		:at => 1,
		:join => 2,
		:complete_choose => 3,
		:complete => 4,
		:private => 5
	}


  after_create :realtime_push_to_client,:realtime_mail_to_client
  def realtime_push_to_client
  	notifications = self.to_user.notifications.unread
  	counts = []
  	reply = 0
  	at = 0
  	system = 0
  	pri = 0
  	notifications.each do |n|
  		reply+=1 if n.notif_type == Notification::TYPE[:reply]
  		at+=1 if n.notif_type == Notification::TYPE[:at]
  		system+=1 if n.notif_type == Notification::TYPE[:join]
  		system+=1 if n.notif_type == Notification::TYPE[:complete_choose]
  		system+=1 if n.notif_type == Notification::TYPE[:complete]
  		pri+=1 if n.notif_type == Notification::TYPE[:private]
  	end
  	counts = {"reply" => reply, "at" => at, "system" => system, "pri" =>pri, "counts" => reply+at+system+pri}
  	FayeClient.send("/notifications_count/#{self.to_user.id}", :notif => counts)
  end

  def realtime_mail_to_client
    subject = "[书愿网]"
    avatar = self.from_user.avatar.url
    body = self.body
    from_user_name = self.from_user.name 
    created_at = I18n.l(self.created_at, :format => :long)
    post_id = self.post.id unless self.post.blank?
    post_title = self.post.title unless self.post.blank?
    if  self.notif_type == Notification::TYPE[:reply] 
      subject += "#{self.from_user.name}评论了您的#{self.post.title}"
      UserMailer.remind_reply(self,self.to_user.email,subject, avatar, body, from_user_name, created_at,post_id, post_title).deliver
    elsif self.notif_type == Notification::TYPE[:at]
      subject += "#{self.from_user.name}在#{self.post.title}@了你"
      UserMailer.remind_at(self,self.to_user.email,subject, avatar, body, from_user_name, created_at).deliver

    elsif self.notif_type == Notification::TYPE[:join] 
      subject += "#{self.from_user.name}刚申请了参与你发布的#{self.post.title}"
      UserMailer.remind_system(self,self.to_user.email,subject, avatar, body, from_user_name, created_at,post_id, post_title).deliver
    elsif self.notif_type == Notification::TYPE[:complete_choose] 
      subject += "#{self.from_user.name}在#{self.post.title}通过了你的申请"
      UserMailer.remind_system(self,self.to_user.email,subject, avatar, body, from_user_name, created_at,post_id, post_title).deliver
    elsif self.notif_type == Notification::TYPE[:complete]
      subject += "#{self.from_user.name}在#{self.post.title}给你评价"
      UserMailer.remind_system(self,self.to_user.email,subject, avatar, body, from_user_name, created_at,post_id, post_title).deliver
    elsif self.notif_type == Notification::TYPE[:private] 
      subject += "#{self.from_user.name}给您发了一条私信"
      UserMailer.remind_private(self,self.to_user.email,subject, avatar, body, from_user_name, created_at).deliver

    end 
      # UserMailer.remind(self,self.to_user.email,subject).deliver
  end

end
