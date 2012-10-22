class ApplyForTest
  include Mongoid::Document
  field :email,  :type => String, :default => ""
  field :name

  validates_presence_of :name, :email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

end
