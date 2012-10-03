#encoding: utf-8
module UserHelper

def account_follow_tag(account)
    return "" if current_account.blank?
    return "" if account.blank?
    class_name = "follow"
    if account.follower_ids.include?(current_account.id)
      class_name = "followed"
    end

    link_to "关注", "#", :onclick => "return Window.Users.follow(this);",
                        'data-id' => account.id,
                        'data-followed' => (class_name == "followed"),
                        :class => 'btn btn-primary  btn-block',
                        :rel => "twipsy"
  end


end
