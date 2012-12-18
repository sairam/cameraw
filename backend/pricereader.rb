require 'yaml'
require 'pry'

$LOAD_PATH << "."
require 'config'
$LOAD_PATH << "pricereader"

Dir.open('pricereader').each{|x| require x if x =~ /\.rb/}

# data = [BuyThePriceLinks, ZoominLinks, InfibeamLinks, FlipkartLinks, DPReviewLinks].map do |klass|
#   t = klass.new
#   t.load
#   t
# end
