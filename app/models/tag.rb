class Tag
  include Mongoid::Document
  has_and_belongs_to_many :posts
  field :name
  field :created_at, type: Date, :default => Time.new

  def self.autocomplete(q)
    self.where(name: /#{q}/)
  end
  
  def self.autocomplete_data(q)
    Tag.autocomplete(q).map(&:name)
  end
end
