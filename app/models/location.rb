class Location
  include Mongoid::Document

  field :name
  field :pin_yin
  field :created_at, type: Date, :default => Time.new
  field :updated_at, type: Date, :default => Time.new

  def to_param
    "#{name}"
  end

  
end
