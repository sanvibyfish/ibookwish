class Tag
  include Mongoid::Document
  has_and_belongs_to_many :posts
end
