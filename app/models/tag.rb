class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :posts
  field :name

  validates_uniqueness_of :name

  def self.autocomplete(q)
    self.where(name: /#{q}/)
  end
  
  def self.autocomplete_data(q)
    Tag.autocomplete(q).map(&:name)
  end

  def self.assign_tags(tag_names) 
    names = tag_names.split(',')
    names.map { |name| Tag.find_or_create_by(name: name) } 
  end

  def to_param
    "#{name}"
  end

end
