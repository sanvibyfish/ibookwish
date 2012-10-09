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
		Float(coordinates[0]) + "," + Float(coordinates[1])
	end

	def post_image_tag(post, options = {})
		options[:style] ||= :small
		style = case options[:style].to_s
		when "240x240" then "100x100"
		when "240x240" then "240x240"
		when "48x48" then "48x48"
		else options[:style].to_s
		end
		link_to image_tag(post.image.url(style)), post_path(post),:class => options[:class]
	end

end
