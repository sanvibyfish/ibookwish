class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :from_user, :class_name => "Account"
  belongs_to :post
  belongs_to :to_user, :class_name => "Account"
  field :body
  field :read , :type => Boolean, :default => false



  
end
