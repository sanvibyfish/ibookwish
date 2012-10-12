class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::SoftDelete
  
  belongs_to :account
  belongs_to :commentable, :polymorphic => true
  belongs_to :post
  
  field :body, type: String
  

  after_create do
    send_notification(self.id)
  end

  def send_notification(comment_id)
    comment = Comment.find(comment_id)
    return if comment.blank?
    post = comment.post
    return if post.blank?
    # 给发帖人发回帖通知

    if comment.account_id != post.account_id
     notif =  Notification.create :from_user => comment.account_id, :to_user => comment.post.account_id, :body => comment.body, 
        :type => Notification::TYPE[:reply], :post => comment.post
        comment.account.send_ids.push(notif.id)
        comment.post.account.notification_ids.push(notif.id)
    end
    
    #给@的人发通知
    comment.body.scan(%r{@[a-zA-Z0-9_\u4e00-\u9fa5]{1,20}}).each { |nickname|
        account = Account.find_by(:nickname => nickname.delete("@"))
        next if account.blank?
     notif_at =   Notification.create :from_user => comment.account_id, :to_user => account.id, :body => comment.body, 
        :type => Notification::TYPE[:at], :post => comment.post
        comment.account.send_ids.push(notif_at.id)
        account.notification_ids.push(notif_at.id)
    }

  end


end
