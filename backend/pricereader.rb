require 'yaml'
require 'pry'

$LOAD_PATH << "."
require 'config'
$LOAD_PATH << "pricereader"

Dir.open('pricereader').each{|x| require x if x =~ /\.rb/}
