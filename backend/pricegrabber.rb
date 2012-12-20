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
# s = HomeShop18HTMLScraper.new
# s = SmartShopperHTMLScraper.new
# s = LandMarkHTMLScraper.new
# s = IndiaPlazaHTMLScraper.new
# s = JJMehtaHTMLScraper.new
# s = SnapDealHTMLScraper.new
# s.perform

# [BuyThePriceHTMLScraper, ZoominHTMLScraper, InfibeamHTMLScraper, FlipkartHTMLScraper, DPReviewInfoGrabber, HomeShop18HTMLScraper, SmartShopperHTMLScraper, LandMarkHTMLScraper, IndiaPlazaHTMLScraper, JJMehtaHTMLScraper, SnapDealHTMLScraper].each do |klass|
#   klass.new.perform
# end
#