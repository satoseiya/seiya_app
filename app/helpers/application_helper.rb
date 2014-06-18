module ApplicationHelper
	#ページごとの完全なタイトルを渡す
	def full_title(page_title)
		base_title = "SeiyaApp";
		if page_title.empty?
			"#{base_title}"
		else
			"#{base_title} | #{page_title}"
		end
	end
end
