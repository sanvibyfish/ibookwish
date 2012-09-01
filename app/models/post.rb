# coding: utf-8
class Post
  include Mongoid::Document
  field :isbn, type: String
  field :author, type: String
  field :title, type: String
  field :publisher
  field :price
  field :image
  field :created_at, type: Date, :default => Time.new
  field :updated_at, type: Date
  field :dream, type: String

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags


  attr_accessor :category_names, :tag_names
  # attr_accessible :category_names, :author, :source, :platform, :size, :description, :watch
  after_create :assign_categories, :assign_tags
  after_update :assign_categories, :assign_tags
  validates_presence_of :category_names, :tag_names, :isbn, :dream
  validates_length_of :isbn,  :within => 10..13, :too_long => "请输入正确的ISBN", :too_short => "请输入正确的ISBN"


  protected
  def assign_categories
    names = category_names.split(',')
    categories << names.map { |name| Category.find_or_create_by(name: name) } 
  end

  def assign_tags
    names = tag_names.split(',')
    tags << names.map { |name| Tag.find_or_create_by(name: name) } 
  end

end
