=begin
- url: /product/canon-eos-5d-mark-iii-kit-ef-24-105-f4l-is-usm-lens/
  image: /published/publicdata/SSLIVESSLIVE/attachments/SC/products_pictures/Canon_5D_Mark_III_Kit_L_thm.jpg
  name: Canon EOS 5D Mark III Kit EF 24-105 F4L IS USM Lens
  price: 242592.0
  category: slrs
=end

class SmartShoppersLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = SmartShoppersConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| SmartShoppers.new(product) }
  end

end
class SmartShoppers < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = ""
  end
end

# l = SmartShoppersLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}