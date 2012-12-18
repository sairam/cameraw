=begin
Sample for BuythePrice
  url: http://www.buytheprice.com/shop-online-deal/nikon-d7000---with-nikon-af-s-18-105mm-__907
  image: http://static3.buytheprice.com/pimages/iproduct/907.jpg
  name: Nikon D7000 ( WIth Nikon AF-S 18-105MM)
  price: '77690'
  category: 'slrs'
=end

class BuyThePriceLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = BuythePriceConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| BuyThePrice.new(product) }
  end

end
class BuyThePrice < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    @name = product['name'] # sample is Nikon D7000 ( WIth Nikon AF-S 18-105MM)
    @code = product['url'].split("__")[-1]  # sample is 907
    @url = product['url']   # sample is http://www.buytheprice.com/shop-online-deal/nikon-d7000---with-nikon-af-s-18-105mm-__907
    @image = product['image']
    @source = self.class.name
    @category = product['category']
    @brand = @name.split(" ")[0]
    @model = @name.split(" ",2)[1]
    @brand_name = @brand
    # shortdown_category
    # debug
  end
end

# l = BuyThePriceLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Canon"=>82, "Nikon"=>61, "FUJIFILM"=>7, "Panasonic"=>52, "Sony"=>52, "NIKON"=>3, "Wespro"=>4, "New"=>1, "Kodak"=>15, "VOX"=>4, "Samsung"=>14, "Fujifilm"=>23, "NIkon"=>1, "Olympus"=>36, "PANASONIC"=>2, "Haier"=>5, "Casio"=>8}
# {"slrs"=>65, "camcoders"=>43, "compacts"=>262}