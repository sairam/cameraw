class BuyThePriceHTMLScraper < HTMLScraper
  # first page is http://www.buytheprice.com/category__digital-cameras-91~1.html
  @@compacts = "http://www.buytheprice.com/category__digital-cameras-91~PAGE.html"
  @@camcoders = "http://www.buytheprice.com/category__camcorders-95~PAGE.html"
  @@slrs = "http://www.buytheprice.com/category__digital-slr-92~PAGE.html"
  @@lenses = "http://www.buytheprice.com/category__camera-lenses-505~PAGE.html"

  def initialize
    @urls = {"slrs" => @@slrs, "camcoders" => @@camcoders, "compacts" => @@compacts, "lenses" => @@lenses}
    @complete_data = []
    @filename = BuyThePriceConfig::Filename
    @per_page = 30

    @total_count = "span.blue"
    @product_details = "div#results .product-block1"
  end

private
  def get_page_count(page)
    page.css(@total_count).text().match(/^(.+) products/)[1]
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
