#encoding: utf-8
module UserHelper


def account_follow_tag(account)
    return "" if current_account.blank?
    return "" if account.blank?
    return "" if current_account == account
    display_text = " 关注"
    display_icon = "<i class='icon-white'></i>"
    class_name = "btn btn-primary"
    followed = false
    if account.follower_ids.include?(current_account.id)
      class_name = "btn btn-danger"
      display_text = " 取消关注"
      display_icon = "<i class='icon-remove icon-white'></i>"
      followed = true
    end

    link_to raw(display_icon)+display_text, "#", :onclick => "return Users.follow(this);",
                        'data-id' => account.id,
                        :class => class_name,
                        'data-followed' => followed
  end


end
