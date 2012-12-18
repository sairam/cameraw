
class DPReviewLinks < PriceReader
  attr_accessor :filename, :product_categories

  def initialize
    @filename = DPReviewConfig::Filename
    @products = []
    # @product_categories = {}
  end

  def load
    YAML::load(File.open(@filename).read).each do |product|
      image = "http://4.static.img-dpreview.com/products_data/products/#{product['dprCode']}/generated/#{product['dprCode']}-80x80.png?v=1870"
      @products << DPReview.new(product['name'], product['dprCode'], product['url'], image)
    end
  end
end

=begin
Sample for DPReview
  name: Pentax smc DA 16-45mm F4 ED AL
  dprCode: pentax_16-45_4
  url: http://www.dpreview.com/products/pentax/lenses/pentax_16-45_4
  image: "http://4.static.img-dpreview.com/products_data/products/pentax_16-45_4/generated/pentax_16-45_4-80x80.png?v=1875"
  isDiscontinued: false
=end
class DPReview < SimpleSource
  def initialize(name, code, url, image)
    @name = name
    @code = code
    @url = url
    @image = image
    @source = self.class.name
    @brand, @category = url.match(/products\/([a-z]+)\/([a-z]+)/).to_a[1..2]
    @model = get_model
  end

  def brand_name
    case @brand
    when "konicaminolta"
      "Konica Minolta"
    else
      @brand.capitalize
    end
  end

  def get_model
    short_code = case @brand
    when "olympus" ["oly","olympus"]
    when "fujifilm" ["fuji","fujifilm"]
    when "konicaminolta" ["konica","minolta"]
    when "nikon" ["nikon", "nikkor"]
    else @brand
    end
    if short_code.class == Array
      short_code.each do |our_code|
        t = @code.match(/#{our_code}_(.+)/i)
        return t[1] unless t.nil?
      end
    else
      t = @code.match(/#{short_code}_(.+)/i)
      return t[1] unless t.nil?
      debug
      return @code
      # binding.pry
    end
  end
end

# l = DPReviewLinks.new
# l.load
# puts l.brands
# puts l.brands_with_count
# puts l.categories
# puts l.categories_with_count
#{"compacts"=>1685, "slrs"=>230, "lenses"=>543}
#{"agfa"=>8, "fujifilm"=>194, "leica"=>56, "ricoh"=>49, "canon"=>315, "hp"=>46, "nikon"=>268, "samsung"=>154, "casio"=>114, "kodak"=>148, "olympus"=>252, "sigma"=>73, "contax"=>2, "konicaminolta"=>52, "panasonic"=>171, "sony"=>268, "epson"=>16, "kyocera"=>15, "pentax"=>161, "tamron"=>27, "samyang"=>9, "tokina"=>11, "hartblei"=>3, "schneider"=>1, "voigtlander"=>16, "kenko"=>6, "zeiss"=>23}
