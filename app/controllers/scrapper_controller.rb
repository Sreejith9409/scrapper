class ScrapperController < ApplicationController
	def index

	end

	def get_words_count
		@words_arr = WordScrapper.new(params["scrapper"]["url"], params["scrapper"]["count"].to_i).get_most_commonly_used_words
	end
end