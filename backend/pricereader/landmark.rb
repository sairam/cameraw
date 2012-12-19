=begin
- url: /canon-eos-1100d-slr-18-55mm-cameras-22668487/
  image: //static.landmarkonthenet.com/LP00022668487/m108/m152/?dept=cameras&shot=0
  name: Canon EOS 1100D SLR 18-55mm
  price: ''
  category: slrs
=end

class LandMarkLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = LandMarkConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| LandMark.new(product) }
  end

end
class LandMark < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = product['url'].split("-")[-1][0..-2]  # sample is 22668487
  end
end

# l = LandMarkLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}