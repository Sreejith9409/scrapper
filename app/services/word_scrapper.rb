require 'mechanize'
class WordScrapper 

	attr_accessor :scrapping_url, :words_count, :html_data, :commonly_used_words_arr

	# Scrapping url means the url which we need to scrap
	# Words count means how many most commonly used words should be shown

	def initialize(url = "https://hiverhq.com/", words_count=3)
		self.scrapping_url = url
		self.words_count = words_count
		self.html_data = Mechanize.new
		self.commonly_used_words_arr = []
	end

	def get_most_commonly_used_words
		html_counts_hash = {}
		# To get html content of given url
		html = html_data.get(scrapping_url)
		# to get text of title
		text = html.search("title").text
		html_counts_hash = update_html_count(html_counts_hash, text)
		# taking entire body elements
		html.search("body").each do |ht|
			ht.elements.each do |data|
				# taking text of elements
				text = data.text
				html_counts_hash = update_html_count(html_counts_hash, text)
			end
		end
		construct_commonly_used_words(html_counts_hash)
		commonly_used_words_arr
	end

	

	def update_html_count(counts_hash, text)
		if text.present?
			text.split(" ").each do |t|
				counts_hash[t] = counts_hash[t].to_i + 1
			end
		end
		counts_hash
	end

	def  construct_commonly_used_words(counts_hash)
		if counts_hash.present?
			max_counts = counts_hash.values.uniq.max(words_count)
			counts_data_hash = get_counts_data_hash(counts_hash, max_counts)
			max_counts.each do |count|
				counts_data_hash[count].each do |value|
					commonly_used_words_arr << "#{value} appeared #{count} times"
					break if commonly_used_words_arr.size == words_count
				end
				break if commonly_used_words_arr.size == words_count
			end
		end
	end

	def get_counts_data_hash(counts_hash, max_counts)
		counts_data_hash = {}
		counts_hash.each do |k, v|
			if max_counts.include?(v)
				counts_data_hash[v] ||= []
				counts_data_hash[v] << k
			end
		end
		counts_data_hash
	end
end