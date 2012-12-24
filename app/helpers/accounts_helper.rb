#encoding: utf-8
module AccountsHelper
	def user_tagline_tag(user) 
    if user.tagline.blank?
      "暂无签名"
    else
    	truncate(strip_tags(user.tagline), :length => 10, :omission => '...')
    end
  end

  require "digest/md5" 
  def gravatar(email) 
  	gravatar_id = Digest::MD5.hexdigest(email.downcase) 
  	"http://www.gravatar.com/avatar/#{gravatar_id}"
  end

  def user_avatar_custom_tag(user, options = {})

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
			"data-original-title" => "#{options[:title]}",
		 :class => "img-rounded #{options[:image_css]}"), user_path(user),:class => options[:class]
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

	def image_clip(url, options= {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "240x240" then "240x240"
		when "360x360" then "360x360"
		when "100x100" then "100x100"
		else options[:style].to_s
		end
		image_tag "#{url}!#{style}"
	end
end
