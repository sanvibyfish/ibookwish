class Notification
  include Mongoid::Document
  include Mongoid::Timestamps


	belongs_to  :from_user, :class_name => "User", :inverse_of => :sends
	belongs_to	:to_user, :class_name => "User", :inverse_of => :notifications
	field :body
	belongs_to :post
	field :read, :default => false
	
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
  	FayeClient.send("/notifications_count/#{self.to_user.id}", :count => self.to_user.notifications.unread.count)
  end


end
