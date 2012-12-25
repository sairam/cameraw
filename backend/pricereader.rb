require 'yaml'
require 'pry'

current_directory = File.expand_path(File.dirname(__FILE__))+"/"
$LOAD_PATH << current_directory
$LOAD_PATH << current_directory + "pricereader"

require 'config'

Dir.open(current_directory+'pricereader').each{|x| require x if !(x =~ /_/) && (x =~ /\.rb/)}

# binding.pry

def read_all
  [BuyThePriceLinks, ZoominLinks, InfibeamLinks, FlipkartLinks, DPReviewLinks].map do |klass|
    t = klass.new
    t.load
    t
  end
end

# binding.pry
