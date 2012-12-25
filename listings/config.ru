ENV["RACK_ENV"] ||= "development"

require 'slim'
require 'sinatra/base'
require 'bundler/setup'
require 'pry'

$LOAD_PATH << "./lib/" << "."

$LOAD_PATH << "../backend/" << "../backend/pricereader"
require 'pricereader'

MainLinks = DPReviewLinks.new
MainLinks.load
MainLinks.make_brand_mappings

require ::File.expand_path('../cameraw',  __FILE__)

# Running a single application
run Cameraw
