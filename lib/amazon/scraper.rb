# Book scraper
require 'open-uri'
require 'Nokogiri'
require 'pry'

class AmazonCharts::Scraper

	def self.fiction
		doc = Nokogiri::HTML(open("https://www.amazon.com/charts/2018-06-10/mostsold/fiction/"))
			doc.css(".kc-rank-card-metadata").each do |book|
				 AmazonCharts::Book.new({
					title: book.css(".kc-rank-card-title").text.gsub( /\s+/, " " ).strip,
					author: book.css(".kc-rank-card-author").text.gsub("\n", "").strip.gsub("by","").strip,
					publisher: book.css(".kc-rank-card-publisher").text.gsub("\n", "").strip.gsub("PUBLISHER:", "").strip.gsub("by","")
			 	})
		end
	end

	def self.date
		doc = Nokogiri::HTML(open("https://www.amazon.com/charts/2018-06-10/mostsold/fiction/"))
		doc.search(".kc-title-text")
		this_week = doc.search(".kc-title-text").text.split.join(" ")
	end

	def self.non_fiction
		doc = Nokogiri::HTML(open("https://www.amazon.com/charts/2018-06-10/mostsold/nonfiction/"))
			doc.css(".kc-rank-card-metadata").each do |book|
				 AmazonCharts::Book.new({ 
				 	title: book.css(".kc-rank-card-title").text.gsub( /\s+/, " " ).strip, 
				 	author: book.css(".kc-rank-card-author").text.gsub("\n", "").strip.gsub("by","").strip, 
				 	publisher: book.css(".kc-rank-card-publisher").text.gsub("\n", "").strip.gsub("PUBLISHER:", "").strip.gsub("by","")
			 	})
		end
	end
end