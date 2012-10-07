class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email, :encrypted_password, :nickname, :gender
  attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me, :roles, :nickname, :gender, :location, :avatar, :tagline, :roles

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ##Customer Field
  field :nickname
  field :gender, :type => Integer
  belongs_to :location
  mount_uploader :avatar, ImageUploader
  field :tagline
  field :uploader_secure_token
  #正在关注
  has_and_belongs_to_many :following, :class_name => 'Account', :inverse_of => :followers
  #粉丝
  has_and_belongs_to_many :followers, :class_name => 'Account', :inverse_of => :following
  # 用户角色
  field :roles_mask
  ROLES = %w[admin user]



  ##Invitation Token
  field :invitation_token, :type => String
  field :invitation_sent_at, :type => DateTime
  field :invitation_accepted_at, :type => DateTime
  field :invitation_limit, :type => Integer
  field :invited_by_id, :type => Integer
  field :invited_by_type
  validates_length_of :invitation_token, maximum: 60

  has_many :posts

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def role?(role)
    roles.include?(role.to_s)
  end

  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end

  def to_param
    "#{nickname}"
  end

  def push_following(uid)
    return false if uid == self.id
    return false if self.following_ids.include?(uid)
    self.push(:following_ids,uid)
  end

  def pull_following(uid)
    return false if uid == self.id
    self.pull(:following_ids,uid)
  end
  

  def push_follower(uid)
    return false if uid == self.id
    return false if self.follower_ids.include?(uid)
    self.push(:follower_ids,uid)
  end

  def pull_follower(uid)
    return false if uid == self.id
    self.pull(:follower_ids,uid)
  end


  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
end
