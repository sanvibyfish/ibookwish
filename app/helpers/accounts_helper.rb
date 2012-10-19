#encoding: utf-8
module AccountsHelper
	def account_tagline_tag(account) 
    if account.tagline.blank?
      "暂无签名"
    else
     account.tagline 
    end
  end


	def account_avatar_tag(account, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "small" then "30x30"
		when "normal" then "100x100"
		when "240x240" then "240x240"
		when "tiny" then "20x20"
		when "48x48" then "48x48"
		else options[:style].to_s
		end
		
		link_to image_tag(account.avatar.url(style), :rel => "twipsy", "data-placement" => "bottom" ,
			"data-original-title" => "#{account.nickname}<br/>#{account_tagline_tag(account)}<br/>#{account.location.name unless account.location.blank?}",
		 :class => "img-rounded #{options[:image_css]}"), user_path(account),:class => options[:class]
	end
end
