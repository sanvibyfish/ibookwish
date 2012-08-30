class Category
  include Mongoid::Document
  field :name, type: String
  field :text, type: String
  field :created_at, type: Date
  has_and_belongs_to_many :posts
end
