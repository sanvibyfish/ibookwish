# coding: utf-8
class Post
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::Timestamps

  
  field :isbn, type: String
  field :author, type: String
  field :title, type: String
  field :publisher
  field :price
  
  mount_uploader :image, ImageUploader
  field :uploader_secure_token

  field :dream, type: String
   
  belongs_to :account
  has_and_belongs_to_many :tags


  field :coordinates, :type => Array
  belongs_to :location
  field :country
  field :address


  

  attr_accessor :tag_names
  after_create  :assign_tags
  after_update  :assign_tags
  validates_presence_of  :isbn, :dream, :title, :coordinates
  validates_length_of :isbn,  :within => 10..13


  def assign_tags
    unless tag_names.blank?
      tags << Tag.assign_tags(tag_names)
    end 
  end

end
