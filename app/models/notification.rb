class Notification
  include Mongoid::Document
  include Mongoid::Timestamps


	belongs_to  :from_user, :class_name => "Account", :inverse_of => :sends
	belongs_to	:to_user, :class_name => "Account", :inverse_of => :notifications
	field :body
	belongs_to :post
	field :read, :default => false
	
	field :notif_type, :type => Integer, :default => 0 
	
	scope :unread, where(:read => false)
	
	TYPE = {
		:reply => 0,
		:at => 1
	}
end
