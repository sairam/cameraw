# class for DPReview.com information grabber
# currently fetches data from their search API - uses @search_url

class DPReviewInfoGrabber < BasicPriceGrabber
  attr_accessor :processed, :brands, :complete_data, :search_url, :base_url
  def initialize
    @base_url = 'http://www.dpreview.com'
    @brands = {}
    @processed = {}
    @complete_data = []
    @search_url = @base_url + '/products/get-products-for-lookup?brand=BRAND&category=CATEGORY'
    @filename = DPReviewConfig::Filename
    # categories = %w{lenses cameras} # printers, software
    # items by timeline
    # url = "http://www.dpreview.com/products/timeline?year=all"
    # Product image - http://4.static.img-dpreview.com/products_data/products/nikon_d5200/generated/nikon_d5200-80x80.png?v=1875
  end

  def perform
    get_brands

    @brands.each do |href,name|
      # 3 types - compacts, slrs, lenses
      brand, category = href.match(/products\/([a-z]+)\/([a-z]+)/).to_a[1..2]
      puts "Reading data for #{brand} #{category}"
      get_url = @search_url.gsub('BRAND',brand).gsub('CATEGORY',category)
      url_data = open(get_url).read
      @complete_data |= JSON.parse(url_data)['data'] # we use what dpreview provides
      sleep(1)
    end
    save
  end

private
  def get_brands
    [@base_url+'/products/cameras', @base_url+'/products/lenses'].each do |url|
      Nokogiri::HTML(open(url).read).css("div.brand > div.name a").each do |brand|
        @brands[brand['href']] = brand.text
      end
    end
  end

end
