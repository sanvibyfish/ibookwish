class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :posts
  has_many :accounts

  field :body
  field :star_point

  field :state, :type => Integer, :default => 1

  validates_presence_of  :body, :star_point
  validates_length_of :body,  :within => 1..140

  STATE = {
    # 失败
    :fail => -1,
    # 正常
    :normal => 1,
    # 完成
    :success => 2,
  }


end
