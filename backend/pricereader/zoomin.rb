=begin
Sample for Zoomin
  url: http://camera.zoomin.com/digital-slr/eos-60d-kit-iii-ef-s18-201.html
  image: http://a.zi.cm/v20/media/catalog/product/cache/1/small_image/170x/9df78eab33525d08d6e5fb8d27136e95/6/0/60d_18_200_1_1.jpg
  name: Canon EOS 60D Kit III Bundle (EF-S18-200mm f/3.5-5.6 IS Lens)
  price: '90205'
  category: 'slrs'
=end

class ZoominLinks < PriceReader
  attr_accessor :filename

  def initialize
    @filename = ZoominConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| Zoomin.new(product) }
  end

end
class Zoomin < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    @name = product['name'] # Canon EOS 60D Kit III Bundle (EF-S18-200mm f/3.5-5.6 IS Lens)
    @code = product['url'].split("/")[-1].split(".")[0]  # sample is eos-60d-kit-iii-ef-s18-201
    @url = product['url']   # sample is http://camera.zoomin.com/digital-slr/eos-60d-kit-iii-ef-s18-201.html
    @image = product['image']
    @source = self.class.name
    @category = product['category']
    @brand, @model = @name.split(" ",2)
    @brand_name = @brand
    # shortdown_category
    # debug
  end
end

# l = ZoominLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry


# {"Nikon"=>93, "Canon"=>107, "OLYMPUS"=>1, "Panasoinc"=>1, "Panasonic"=>34, "Sony"=>73, "Olympus"=>25, "FUJIFILM"=>1, "Sigma"=>93, "Tamron"=>32, "Samsung"=>22, "Fujifilm"=>37, "Fuji"=>1, "Lytro"=>2}
# {"slrs"=>77, "lenses"=>252, "compacts"=>193}
