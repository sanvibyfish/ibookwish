class Post
  include Mongoid::Document
  field :author, type: String
  field :source, type: String
  field :platform, type: String
  field :size,	type: String
  field :watch, type: Integer
  field :created_at, type: Date
  field :updated_at, type: Date
  field :description, type: String

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags
end
