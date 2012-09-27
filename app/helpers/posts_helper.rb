module PostsHelper
	def tag_name_tag(tag_names)
		@tags = []
		tag_names.each { |tag|
			@tags << tag["name"]
		}
		@tags.join(',')
	end
end
