#encoding: utf-8
module AccountsHelper
	def user_tagline_tag(user) 
    if user.tagline.blank?
      "暂无签名"
    else
     user.tagline 
    end
  end


	def user_avatar_tag(user, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "small" then "30x30"
		when "normal" then "100x100"
		when "240x240" then "240x240"
		when "tiny" then "20x20"
		when "48x48" then "48x48"
		else options[:style].to_s
		end
		
		link_to image_tag(user.avatar.url(style), :rel => "twipsy", "data-placement" => "bottom" ,
			"data-original-title" => "#{user.name}<br/>#{user_tagline_tag(user)}<br/>#{user.location.name unless user.location.blank?}",
		 :class => "img-rounded #{options[:image_css]}"), user_path(user),:class => options[:class]
	end
end
