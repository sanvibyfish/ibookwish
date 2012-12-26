class Authentication 
    include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessible :user_id, :provider, :uid, :access_token

  belongs_to :user

  validates :provider, :uid, :access_token, presence: true
  validates :provider, uniqueness: { scope: :user_id }

  field :uid, :type => String
  field :provider, :type => String
  field :user_id, :type => String
  field :access_token, :type => String

  def self.create_from_hash(user_id, omniauth)
    self.create!(
      user_id:      user_id,
      provider:     omniauth[:provider],
      uid:          omniauth[:uid],
      access_token: omniauth[:access_token]
    )
  end
end