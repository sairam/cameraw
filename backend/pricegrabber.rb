require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'

require 'pry'

$LOAD_PATH << "."
$LOAD_PATH << "pricegrabber"
require 'config'

Dir.open('pricegrabber').each{|x| require x if !(x =~ /_/) && (x=~ /\.rb/) }

# s = BuyThePriceHTMLScraper.new
# s = ZoominHTMLScraper.new
# s = InfibeamHTMLScraper.new
# s = FlipkartHTMLScraper.new
# s = DPReviewInfoGrabber.new
# s.perform

# [BuyThePriceHTMLScraper, ZoomInHTMLScraper, InfibeamHTMLScraper, FlipkartHTMLScraper, DPReviewInfoGrabber].each do |klass|
#   klass.new.perform
# end

