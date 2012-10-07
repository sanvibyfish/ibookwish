class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::SoftDelete
  
  belongs_to :account
  belongs_to :commentable, :polymorphic => true
  belongs_to :post
  
  field :body, type: String
  
end
