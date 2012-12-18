=begin
Sample for Infibeam
url: http://www.infibeam.com//Cameras/i-Nikon-D3100-SLR-Digital-Camera/P-E-C-Nikon-D3100.html?id=Black
  image: http://cdn-img-a-tata.infibeam.net/img/2acf123a/Still_Camera/Nikon_Camera/Nikon_D_Series_D3100/upload/front/Nikon-DSeries-D3100-front_cd374.jpg?wid=180&hei=220
  name: Nikon D3100 DSLR ( AF-S 18-55mm VR Kit Lens) (Black)
  price: '27499'
=end

class InfibeamLinks < PriceReader
  attr_accessor :filename

  def initialize
    @filename = InfibeamConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| Infibeam.new(product) }
  end

end
class Infibeam < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    @name = product['name'] # Nikon D3100 DSLR ( AF-S 18-55mm VR Kit Lens) (Black)
    @code = product['url'].split("/")[-1].split(".")[0]  # sample is P-E-C-Nikon-D3100
    @url = product['url']   # sample is http://www.infibeam.com//Cameras/i-Nikon-D3100-SLR-Digital-Camera/P-E-C-Nikon-D3100.html?id=Black
    @image = product['image']
    @price = product['price']
    @source = self.class.name
    @brand, @model = @name.split(" ",2)
    @brand_name = @brand
    guess_category
    # shortdown_category
    # debug
  end

  def guess_category
    @category = if @url =~ /Camcorder/i
      "camcoders"
    elsif @name =~ /slr/i || @url =~ /slr/i
      "slrs"
    else
      "compacts"
    end
    # binding.pry
  end
end

# l = InfibeamLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>48, "FujiFilm"=>5, "Fujifilm"=>33, "Genius"=>8, "Nikon"=>87, "Sony"=>46, "Panasonic"=>36, "SONY"=>1, "Olympus"=>21, "JVC"=>1, "Kodak"=>1, "Samsung"=>10, "PANASONIC"=>9, "Rollei"=>20, "Polaroid"=>1, "FUJIFILM"=>1, "Wespro"=>1}
# {"compacts"=>259, "slrs"=>32, "camcoders"=>38}