# coding: utf-8
class Post
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :isbn, type: String
  field :author, type: String
  field :title, type: String
  field :publisher
  field :price
  field :image
  field :created_at, type: Date, :default => Time.new
  field :updated_at, type: Date, :default => Time.new
  field :dream, type: String
   
  belongs_to :account
  has_and_belongs_to_many :tags


  field :coordinates, :type => Array
  field :city
  field :state
  field :country
  field :address


  

  attr_accessor :tag_names
  after_create  :assign_tags
  after_update  :assign_tags
  validates_presence_of  :isbn, :dream, :title
  validates_length_of :isbn,  :within => 10..13


  protected


  def assign_tags
    names = tag_names.split(',')
    tags << names.map { |name| Tag.find_or_create_by(name: name) } 
  end

end
