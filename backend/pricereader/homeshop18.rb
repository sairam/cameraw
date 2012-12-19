=begin
- url: "http://www.homeshop18.com/nikon-1-j1-dslr-camera-10-30-mm-lens/camera-camcorders/digital-slrs/product:30122324/cid:3188/?pos=14"
  image: http://stat.homeshop18.com/homeshop18/images/productImages/536/300x300_85154eee6bd7fdd66973d36141d05380.jpg
  name: Nikon 1 J1 DSLR Camera with 10-30 mm Lens
  price: '24225'
  category: slrs

=end
class HomeShop18Links < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = HomeShop18Config::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| HomeShop18.new(product) }
  end

end
class HomeShop18 < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = product['url'].match(/product:([0-9]+)/)[-1]  # sample is 30122324
  end
end

# l = HomeShop18Links.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry
