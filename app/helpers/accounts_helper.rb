module AccountsHelper
	def account_avatar_tag(account, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "small" then "30x30"
		when "normal" then "100x100"
		when "large" then "240x240"
		when "tiny" then "20x20"
		else options[:style].to_s
		end
		link_to image_tag(account.avatar.url(style)), account
	end
end
