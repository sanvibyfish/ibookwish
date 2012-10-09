# coding: utf-8
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  
  field :isbn, type: String
  field :author, type: String
  field :title, type: String
  field :publisher
  field :price
  field :description
  
  mount_uploader :image, ImageUploader
  field :uploader_secure_token

  field :dream, type: String
   
  belongs_to :account
  has_and_belongs_to_many :tags
  has_many :comments

  field :coordinates, :type => Array

  belongs_to :location
  field :address

  has_and_belongs_to_many :wish_users, :class_name => "Account"

  belongs_to :task
  belongs_to :complete_user, :class_name => "Account"


  def push_wish_user(uid)
    self
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



  def assign_tags
    unless tag_names.blank?
      tags << Tag.assign_tags(tag_names)
    end 
  end

end
