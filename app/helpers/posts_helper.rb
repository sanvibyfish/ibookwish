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
end
