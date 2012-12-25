
=begin
Sample from Flipkart.com
  url: http://www.flipkart.com/canon-powershot-sx240-hs-point-shoot/p/itmd8yvy7xfh4hzq?pid=CAMD8CB3ZZE8ZZ5H&ref=6286dbb8-72cf-42c9-86b8-c1f03ce2d753
  image: http://img8a.flixcart.com/image/camera/z/5/h/canon-sx240-hs-100x100-imad8fg84ntnnjpa.jpeg
  name: ! 'Canon PowerShot SX240 HS Point & Shoot: Camera'
  review_info: 15Ratings|4Reviews
  rating_info: 4.5 stars
  price: Rs. 17455
=end

class FlipkartLinks < PriceReader
  attr_accessor :filename

  def initialize
    @filename = FlipkartConfig::Filename
    @products = []
  end

  def load
    @products = YAML::load(File.open(@filename).read).map { |product| Flipkart.new(product) }
  end

end
class Flipkart < SimpleSource
  attr_accessor :brand_name
  def initialize(product)
    super(product)
    @code = product['url'].split("/")[-1].split(".")[0]  # sample is P-E-C-Nikon-D3100
    @url = product['url']+"&affid=cameraw"
    @category = if product['category']
      product['category']
    else
      guess_category
    end
    # shortdown_category
    # debug
  end

  def guess_category
    if url.match(/point-shoot\//)
      "compacts"
    elsif url.match(/slr\//)
      "slrs"
    elsif url.match(/body-only\//)
      "slrs"
    elsif url.match(/mirrorless\//)
      "slrs"
    elsif url.match(/camcorder\//)
      "camcoders"
    elsif url.match(/instant\//)
      "compacts"
    elsif url.match(/video\//)
      "slrs"
    else
      puts "No url match found"
      binding.pry
    end
  end
end

# l = FlipkartLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
# binding.pry

# {"Nikon"=>151, "Sony"=>59, "Canon"=>99, "Fujifilm"=>61, "Olympus"=>38, "Panasonic"=>60, "Samsung"=>24, "Wespro"=>2, "Polaroid"=>1, "Casio"=>2, "BenQ"=>2, "Rollei"=>7, "Philips"=>4, "Aiptek"=>13}
# {"compacts"=>405, "slrs"=>78, "camcoders"=>40}