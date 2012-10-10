module AccountsHelper
	def account_avatar_tag(account, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "small" then "30x30"
		when "normal" then "100x100"
		when "large" then "240x240"
		when "tiny" then "20x20"
		when "48x48" then "48x48"
		else options[:style].to_s
		end
		link_to image_tag(account.avatar.url(style), :rel => "twipsy", "data-placement" => "bottom" ,
			"data-original-title" => "#{account.nickname}<br/>#{account.tagline if account.tagline?}<br/>#{account.location.name}",
		 :class => "img-rounded #{options[:image_css]}"), user_path(account),:class => options[:class]
	end
end
