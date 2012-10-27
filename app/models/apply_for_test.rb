class ApplyForTest
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email,  :type => String, :default => ""
  field :name
  field :state, :type => Integer, :default => 0

  STATE = {
  	:normal => 0,
  	:sent => 1,
  	:signup => 2
  }

  validates_presence_of  :email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates_uniqueness_of :email

end
