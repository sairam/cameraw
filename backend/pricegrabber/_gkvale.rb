
class GKValeHTMLScraper < HTMLScraper
  @@compacts = "http://www.gkvale.com/digital-cameras.html?order=price&dir=asc&limit=all"
  @@slrs = "http://www.gkvale.com/d-slrs-1.html?order=price&dir=asc&limit=all"

  def initialize
    @urls = {"slrs" => @@slrs, "compacts" => @@compacts}
    @complete_data = []
    @filename = GKValeConfig::Filename
    @per_page = 3000

    @total_count = ""
    @product_details = "div#results .product-block1"
  end

private
  def get_page_count(page)
    -1
  end
  def parse_data product_section
    print "."
    {
    'url' => product_section.css(' > a').attr('href').value,
    'image' => product_section.css('div.pro-block a img').attr('src').value,
    'name' => product_section.css('div.pro-block a img').attr('alt').value,
    'price' => product_section.css(' > a').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end
