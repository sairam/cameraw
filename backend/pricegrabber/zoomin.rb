class ZoominHTMLScraper < HTMLScraper

  @@slrs = "http://camera.zoomin.com/digital-slr.html?dir=desc&limit=30&order=created_at&p=PAGE"
  @@lenses = "http://camera.zoomin.com/accessories/lenses.html?dir=desc&limit=30&order=created_at&p=PAGE"
  @@compacts = "http://camera.zoomin.com/cameras-1.html?dir=desc&limit=30&order=created_at&p=PAGE"

  def initialize
    @urls = {"slrs" => @@slrs, "lenses" => @@lenses, "compacts" => @@compacts}

    @per_page = 30
    @filename = ZoominConfig::Filename
    @total_count = "div.footertoolbar p.amount.clearfix"
    @product_details = "ul.product-listing li"
    @complete_data = []
  end

private
  def parse_data product_section
    print "."
    {
    'url' => product_section.css('a.product-image').attr('href').value,
    'image' => product_section.css('img').attr('src').value,
    'name' => product_section.css('a.product-image').attr('title').value,
    'price' => product_section.css('span.price').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    # add out of stock / availability information
    }
  end

  def get_page_count(page)
    page.css(@total_count).text().strip.match("([0-9]+) total")[1]
  end
end

