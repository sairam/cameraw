=begin
- url: http://jjmehta.com/shop/Olympus_E-PM1.html
  image: http://jjmehta.com/shop/images/T/xctmpFISs3e.png
  name: ! 'Olympus PEN E-PM1 W/14-42mm Lens '
  price: '23490.00'
  category: slrs
=end

class JJMehtaLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = JJMehtaConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| JJMehta.new(product) }
  end

end
class JJMehta < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = ""
  end
end

# l = JJMehtaLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}