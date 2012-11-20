# coding: utf-8
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  include Redis::Objects


  field :isbn, type: String
  field :author, type: String
  field :title, type: String
  field :publisher
  field :price
  field :description
  
  mount_uploader :image, ImageUploader
  field :uploader_secure_token

  field :dream, type: String
   
  belongs_to :user, :inverse_of => :posts
  has_and_belongs_to_many :tags
  has_many :comments

  field :coordinates, :type => Array

  belongs_to :location
  field :address

  has_and_belongs_to_many :wish_users, :class_name => "User", :inverse_of => :wish_posts
  belongs_to :complete_user, :class_name => "User", :inverse_of => :complete_posts
  field :rating_body
  field :rating,  :type => Integer
  counter :hits, :default => 0
  index({ coordinates: '2d' })

  RATING_STATE = {
    :up => 1,
    :down => 0
  }

  field :state , :type => Integer, :default => 1

  STATE = {
    :fail => -1,
    :normal => 1,
    :success => 2
  }


  def push_wish_user(uid)
    return false if self.wish_user_ids.include?(uid)
    self.push(:wish_user_ids,uid)   
  end

  before_create :default_value_for_create
  def default_value_for_create
    self.state = STATE[:normal]
  end

  attr_accessor :tag_names
  after_create  :assign_tags
  after_update  :assign_tags
  validates_presence_of  :isbn, :dream, :title, :coordinates
  validates_length_of :isbn,  :within => 10..13
  validates_length_of :dream,  :within => 1..140
  validates :isbn, :numericality => { :only_integer => true }

  def send_notification(type, from_user, to_user, body)
    notif =  Notification.create :from_user => from_user.id, :to_user => to_user.id, :body => body, 
        :notif_type => type, :post => self
        from_user.send_ids.push(notif.id)
        to_user.notification_ids.push(notif.id)
    
  end




  def assign_tags
    unless tag_names.blank?
      tags << Tag.assign_tags(tag_names)
    end 
  end

end
