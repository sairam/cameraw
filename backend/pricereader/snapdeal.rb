=begin
- url: http://www.snapdeal.com/product/canon-eosm-181mp-mirrorless-camera/539316
  image: http://i1.sdlcdn.com/img/product/main/80x93/UC_Cnn_EOS_M_18_55_Red_M_1_2xrz.jpg
  name: Canon EOS-M 18.1MP Mirrorless Camera (Red) (18-55mm IS STM Lens) with Speedlite
    90x Flash
  price: 49995
  category: slrs

=end

class SnapDealLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = SnapDealConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| SnapDeal.new(product) }
  end

end
class SnapDeal < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = product['url'].split("/")[-1]  # sample is 539316
  end
end

# l = SnapDealLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}