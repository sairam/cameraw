class SnapDealHTMLScraper < HTMLScraper

  @@lenses = "http://www.snapdeal.com/json/product/get/search/296/START_OFFSET/50?q=Type%253ALens%2BCap%255E%2BLens%2BCleaner%255E%2BLens%2Bcase%255E%2BLenses%257C&sort=plrty1_Lenses%20&keyword=&clickSrc=&viewType=Grid"

  @@camcorders = "http://www.snapdeal.com/json/product/get/search/293/START_OFFSET/50?q=&sort=plrty&keyword=&clickSrc=&viewType=Grid"
  @@compacts = "http://www.snapdeal.com/json/product/get/search/291/START_OFFSET/50?q=&sort=plrty&keyword=&clickSrc=&viewType=Grid"
  @@slrs = "http://www.snapdeal.com/json/product/get/search/292/START_OFFSET/50?q=&sort=plrty&keyword=&clickSrc=&viewType=Grid"

  def initialize
    @urls = {"slrs" => @@slrs, "camcorders" => @@camcorders, "compacts" => @@compacts, "lenses" => @@lenses}
    @base_url = "http://www.snapdeal.com/"
    @base_image_url = "http://i1.sdlcdn.com/"
    @complete_data = []
    @filename = SnapDealConfig::Filename
    @per_page = 50

    @total_count =  ""
    @product_details = "div#results .product-block1"
  end

private

  def scrape_from_page(page)
    page['minProductResponseDTO']['productDtos'].map do |product_section|
      parse_data(product_section)
    end
  end

  def get_page_data(url)
    JSON.parse(open(url).read)
  end

  def get_page_count(page)
    page['minProductResponseDTO']['numberFound']
  end

  def parse_data product_section
    print "."
    {
    'url' => @base_url + product_section['pageUrl'],
    'image' => @base_image_url + product_section['imageForMobile'],
    'name' => product_section['name'],
    'price' => product_section['price'],
    # startDate
    }
  end

end
