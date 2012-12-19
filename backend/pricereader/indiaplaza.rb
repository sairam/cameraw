=begin
- url: /nikon-d-3200-kit-18-55vr-lens-dslr-cameras-cameras-cam20120605ang002-10.htm
  image: http://images.indiaplaza.com/cameras/images/CAM20120605ANG002-T.jpg
  name: Nikon D-3200 Kit (18-55VR Lens)
  price: '35356'
  category: slrs

=end

class IndiaPlazaLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = IndiaPlazaConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| IndiaPlaza.new(product) }
  end

end
class IndiaPlaza < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = product['url'].match(/cameras-(.*)\.htm/)[-1]
  end
end

# l = IndiaPlazaLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}