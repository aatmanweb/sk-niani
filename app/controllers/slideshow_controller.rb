class SlideshowController < ApplicationController
	def slideshow
  	@allquote = Quote.all.sort_by{rand}.slice(0,10)
	end
end
