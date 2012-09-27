class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :pin_yin

  validates_uniqueness_of :name

  def to_param
    "#{name}"
  end

  
end
