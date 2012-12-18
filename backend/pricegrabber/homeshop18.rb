class HomeShop18HTMLScraper < HTMLScraper
  @@slrs = "http://www.homeshop18.com/digital-slrs/categoryid:3188/search:*/start:START_OFFSET/"
  @@compacts = "http://www.homeshop18.com/digital-cameras/categoryid:3178/search:*/start:START_OFFSET/"
  @@lenses = "http://www.homeshop18.com/lens/categoryid:8931/search:*/start:START_OFFSET/"
  @@camcoders = "http://www.homeshop18.com/camcorders/categoryid:3164/search:*/start:START_OFFSET/"

  def initialize
    @urls = {"slrs" => @@slrs, "camcoders" => @@camcoders, "compacts" => @@compacts, "lenses" => @@lenses }
    @complete_data = []
    @filename = HomeShop18Config::Filename
    @per_page = 24

    @total_count = "div.browse_result_title"
    @product_details = "div.product_div"
  end

private
  def get_page_count(page)
    page.css(@total_count).text().match(/\(([0-9]+)\) /)[1]
  end
  def parse_data product_section
    print "."
    {
    'url' => product_section.css('p.product_image > a').attr('href').value,
    'image' => product_section.css('p.product_image > a img').attr('src').value,
    'name' => product_section.css('p.product_title > a').attr('title').value,
    'price' => product_section.css('p span.product_new_price').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end

