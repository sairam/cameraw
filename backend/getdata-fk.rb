require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

sitemapurl = 'http://www.flipkart.com/camera/'
baseurl = 'http://www.flipkart.com/cameras/'

a = Mechanize.new { |agent|
   agent.user_agent_alias = 'Mac Safari'
}

file = open('/Users/ram/Downloads/data/flipkart.com/alldata.yaml','w+')

processed = {}

a.get(sitemapurl) do |page|
  page.links_with(:href => /camera\/2\-/ ).each do |link|
    unless processed.has_key? link.href
      processed[link.href]=link.text.strip
      puts 'Loading %-30s %s ' % [link.href, link.text.strip]
      begin  
        products_page = a.click link
        products_page.links_with(:href => /cameras\//).each do |plink|
          next if processed.has_key? plink.href
          processed[plink.href] = plink.text.strip
          puts 'Loading %-30s %s ' % [plink.href, plink.text.strip]
          begin 
            data = a.click plink
            file.puts data.at("//span[@id='fk-mprod-our-id']").text.split(/\n/).join(' ').strip + "\t" + plink.text.strip 
            # exit
          rescue => e
            $stderr.puts "#{e.class}: #{e.message}"
          end
        end
      end
    end
  end
end

file.close