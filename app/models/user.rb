#coding:utf-8
class User
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

  validates_presence_of :email, :encrypted_password, :name, :gender
  attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me, :roles, :name, :gender, :location, :avatar, :tagline, :roles, :ilike, :discover, :info, :school, :realname, :phone
  validates_uniqueness_of :name, :email

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
  field :name
  field :gender, :type => Integer
  field :ilike
  field :discover
  field :info 
  field :school
  belongs_to :location
  mount_uploader :avatar, ImageUploader
  field :tagline
  field :uploader_secure_token
  #正在关注
  has_and_belongs_to_many :following, :class_name => 'User', :inverse_of => :followers
  #粉丝
  has_and_belongs_to_many :followers, :class_name => 'User', :inverse_of => :following
  # 用户角色
  field :roles_mask
  ROLES = %w[admin user]
  has_many :notifications, :class_name => "Notification",:inverse_of => :to_user
  has_many :sends, :class_name => "Notification",:inverse_of => :from_user
  has_many :posts, :inverse_of => :user
  has_and_belongs_to_many :wish_posts, :class_name => "Post",:inverse_of => :wish_user
  has_many :complete_posts, :class_name => "Post", :inverse_of => :complete_user
  field :realname
  field :phone
  validates :phone, :numericality => { :only_integer => true }, :allow_blank => true
  ##Invitation Token
  field :invitation_token, :type => String
  field :invitation_sent_at, :type => DateTime
  field :invitation_accepted_at, :type => DateTime
  field :invitation_limit, :type => Integer
  field :invited_by_id, :type => Integer
  field :invited_by_type
  validates_length_of :invitation_token, maximum: 60
  validates_format_of :name, :with => /\A([\w\u4e00-\u9fa5])+\z/i, :message => "只支持中文，数字，字母"
  field :coordinates, :type => Array
  field :address

  def self.to_csv()
   require 'csv'
   users = User.all

   CSV.generate do |csv|
    csv << ["email"]
    users.each do |user|
      csv << [user.email]
    end
  end
end


  before_create  :get_gavatar
  def get_gavatar
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase) 
    self.remote_avatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.jpeg"
  end


  def read_notifications(notifications)
    unread_ids = notifications.find_all{|notification| !notification.read?}.map(&:_id)
    if unread_ids.any?
      self.notifications.update_all(:read => true)
    end
  end


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
    "#{ name }"
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

  def push_wish_post(uid)
    return false if self.wish_post_ids.include?(uid)
    self.push(:wish_post_ids,uid)   
  end

  #FIXME 未加入
  def push_complete_post(uid)
    return false if self.complete_post_ids.include?(uid)
    self.push(:complete_post_ids,uid)   
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
