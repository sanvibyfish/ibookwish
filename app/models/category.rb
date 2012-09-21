class Category
  include Mongoid::Document
  field :name, type: String
  field :text, type: String
  field :created_at, type: Date, :default => Time.new


  def self.autocomplete(q)
    self.where(name: /#{q}/)
  end
  
  def self.autocomplete_data(q)
    Category.autocomplete(q).map(&:name)
  end
end
