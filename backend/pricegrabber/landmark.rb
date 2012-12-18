class LandMarkHTMLScraper < HTMLScraper

  @@compacts = "http://www.landmarkonthenet.com/cameras/all/?type=Point+%26+Shoot&page=PAGE"
  @@slrs = "http://www.landmarkonthenet.com/cameras/all/?type=D-SLR&page=PAGE"
  @@camcorders = "http://www.landmarkonthenet.com/cameras/all/?type=Camcorder&page=PAGE"
  @@lenses = "http://www.landmarkonthenet.com/camera-accessories/lenses/?page=PAGE"

  def initialize
    @urls = {"slrs" => @@slrs, "camcorders" => @@camcorders, "compacts" => @@compacts, "lenses" => @@lenses}
    @complete_data = []
    @filename = LandMarkConfig::Filename
    @per_page = 30

    @total_count = "div.pagination-wrapper ul.pagination li.items"
    @product_details = "article.product.product-cameras"
  end

private
  def get_page_count(page)
    page.css(@total_count).text().match(/([0-9]+) items/)[1]
  end
  def parse_data product_section
    print "."
    {
    'url' => product_section.css('div.image > a').attr('href').value,
    'image' => product_section.css('div.image > a img').attr('src').value,
    'name' => product_section.css('div.image > a img').attr('alt').value,
    'price' => product_section.css('span.pricelabel span.WebRupee-print').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end