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


  after_create :realtime_push_to_client
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


end
