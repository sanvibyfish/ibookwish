#encoding: utf-8
module UserHelper


def user_follow_tag(user)
    return "" if current_user.blank?
    return "" if user.blank?
    return "" if current_user == user
    display_text = " 关注"
    display_icon = ""
    class_name = "label label-info"
    followed = false
    if user.follower_ids.include?(current_user.id)
      class_name = "label label-important"
      display_text = " 取消"
      display_icon = "<i class='icon-remove icon-white'></i>"
      followed = true
    end

    link_to raw(display_icon)+display_text, "#", :onclick => "return Users.follow(this);",
                        'data-id' => user.id,
                        :class => class_name,
                        'data-followed' => followed
  end


end
