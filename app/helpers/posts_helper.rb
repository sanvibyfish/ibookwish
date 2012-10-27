#coding = utf-8
module PostsHelper
	def tag_name_tag(tag_names)
		@tags = []
		tag_names.each { |tag|
			@tags << tag["name"]
		}
		@tags.join(',')
	end

	def display_latlng_tag(coordinates)
		coordinates[0].to_s + "," + coordinates[1].to_s
	end

	def post_image_tag(post, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "100x100" then "100x100"
		when "240x240" then "240x240"
		when "360x360" then "360x360"
		else options[:style].to_s
		end
		link_to image_tag(post.image.url(style)), post_path(post),:class => options[:class]
	end

	def join_count_tag(post)
		if post.wish_users?
			 post.wish_users.count
		else
			 "0"
		end
	end

	def comment_count_tag(post)
		if post.comments?
			post.comments.count
		else
			"0"
		end
	end

	def post_state_tag(state)
		if Post::STATE[:success] == state
			"已结束"
		end
	end

	def post_rating_tag(rating)
		if Post::RATING_STATE[:up] == rating
			"<i class='icon icon-thumbs-up'></i>"
		else
			"<i class='icon icon-thumbs-down'></i>"
		end
	end


	def item_count_tag(icon_class,title,href,count)
		"<span class='item' rel='twipsy' title='#{title}'><i class='#{icon_class}'></i>#{link_to count,href}</span>"
	end
end
