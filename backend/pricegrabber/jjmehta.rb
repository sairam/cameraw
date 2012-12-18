class JJMehtaHTMLScraper < HTMLScraper
  @@camcorders = ["Panasonic-Video-Camera/", "Sony-Handycam/"].map{|x| "http://jjmehta.com/shop/#{x}?objects_per_page=50"}
  @@slrs = ["Olympus_Pen/", "Sony_/", "Nikon_/", "Canon_/"].map{|x| "http://jjmehta.com/shop/#{x}?objects_per_page=50"}

  @@compacts = ["Samsung-c-262/", "259/", "Olympus-c-261/", "FujiFilm-c-260/", "256/", "255/", "257/"].map{|x| "http://jjmehta.com/shop/#{x}?objects_per_page=50"}

  def initialize
    @urls = {"slrs" => @@slrs, "camcorders" => @@camcorders, "compacts" => @@compacts}
    @complete_data = []
    @filename = JJMehtaConfig::Filename
    @per_page = 300

    @total_count = ""
    @product_details = "div.products.products-list div.item"
  end

private
  def get_page_count(page)
    # currently there are no more than 50 in any of these pages
    -1
  end
  def parse_data product_section
    print "."
    {
    'url' => product_section.css('div.image a').attr('href').value,
    'image' => product_section.css('div.image a img').attr('src').value,
    'name' => product_section.css('div.image a img').attr('alt').value,
    'price' => product_section.css('div.price-row span.price-value').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end
