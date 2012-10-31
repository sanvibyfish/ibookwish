class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::SoftDelete
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  belongs_to :post
  
  field :body, type: String
  
  validates_presence_of  :body

  after_create do
    send_notification(self.id)
  end

  def send_notification(comment_id)
    comment = Comment.find(comment_id)
    return if comment.blank?
    post = comment.post
    return if post.blank?
    # 给发帖人发回帖通知

    if comment.user_id != post.user_id
     notif =  Notification.create :from_user => comment.user_id, :to_user => comment.post.user_id, :body => comment.body, 
        :notif_type => Notification::TYPE[:reply], :post => comment.post
        comment.user.send_ids.push(notif.id)
        comment.post.user.notification_ids.push(notif.id)
    end

    
    #给@的人发通知
    comment.body.scan(%r{@[a-zA-Z0-9_\u4e00-\u9fa5]{1,20}}).each { |name|
        user = User.find_by(:name => name.delete("@"))
        next if user.blank?
     notif_at =   Notification.create :from_user => comment.user_id, :to_user => user.id, :body => comment.body, 
        :notif_type => Notification::TYPE[:at], :post => comment.post
        comment.user.send_ids.push(notif_at.id)
        user.notification_ids.push(notif_at.id)
    }



  end


end
