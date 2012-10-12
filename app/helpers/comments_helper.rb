# coding: utf-8
module CommentsHelper
	def comment_body_tag(comment)
		comment.body.gsub!(/(^|[^a-zA-Z0-9_!#\$%&*@＠])@([a-zA-Z0-9_\u4e00-\u9fa5]{1,20})/io) {
      %(#{$1}<a href="/#{$2}" class="at_user" title="@#{$2}"><i>@</i>#{$2}</a>)
    }
	end

end
