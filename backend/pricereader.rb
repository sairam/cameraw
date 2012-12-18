require 'yaml'
require 'pry'

$LOAD_PATH << "."
$LOAD_PATH << "pricereader"

require 'config'

Dir.open('pricereader').each{|x| require x if !(x =~ /_/) && (x =~ /\.rb/)}

# data = [BuyThePriceLinks, ZoominLinks, InfibeamLinks, FlipkartLinks, DPReviewLinks].map do |klass|
#   t = klass.new
#   t.load
#   t
# end
