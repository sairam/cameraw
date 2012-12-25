=begin
Expects a product with brand_name, category
=end

class PriceReader
  attr_accessor :filename, :products, :brand_mappings
  def initialize
    @products = []
    @brand_mappings = {}
  end

  def make_brand_mappings
    @brand_mappings ||= {}
    @products.map {|p| (@brand_mappings[p.brand] = p.brand_name) unless @brand_mappings.key?(p.brand) }
  end

  def to_s
    self.class.name.gsub("Links","")
  end

  def method_missing(method, *args)
    return @products.send(method, *args) if @products.respond_to?(method)
    super
  end

  def find_by_brand_and_category(p)
    filter_by_categories_and_brands(p.category, p.brand)
  end

  alias :find_by_category_and_brand :find_by_brand_and_category

  def filter_by_category_and_brand(category, brand)
    @products.select{|x| x.brand == brand && x.category == category}
  end

  def brands(pr=nil)
    ((pr || @products).map{|p| p.brand_name}).uniq
  end

  def slrs(pr=nil)
    (pr || @products).select{|p| p.category == 'slrs'}
  end
  def compacts(pr=nil)
    (pr || @products).select{|p| p.category == 'compacts'}
  end
  def camcorders(pr=nil)
    (pr || @products).select{|p| p.category == 'camcorders'}
  end
  def lenses(pr=nil)
    (pr || @products).select{|p| p.category == 'lenses'}
  end

  def brands_with_count(pr=nil)
    (pr || @products).inject(Hash.new(0)) {|h,p| h[p.brand] += 1; h }
  end

  def categories(pr=nil)
    ((pr || @products).map{|p| p.category}).uniq
  end

  def categories_with_count(pr=nil)
    (pr || @products).inject(Hash.new(0)) {|h,p| h[p.category] += 1; h }
  end

  def filter_by_categories(categories)
    (@products.select{|p| categories.include?(p.category)})
  end

  def filter_brands_by_categories(categories)
    brands_with_count(filter_by_categories(categories))
  end

  def filter_by_brands(brands)
    (@products.select{|p| brands.include?(p.brand)})
  end

  def filter_categories_by_brands(brands)
    categories_with_count(filter_by_brands(brands))
  end

  def get_product_by_code(code)
    @products.each{|p| return p if p.code == code}
  end

  def search(search)
    @products.select{|p| p.name =~ /#{search}/i }
  end

end


class SimpleSource
  attr_accessor :name, :code, :url, :image, :source, :price, :brand, :category, :model
  def initialize
    fail "Dont SimpleSource me"
  end

  def initialize(product)
    @name = product['name']
    @url = product['url']
    @image = product['image']
    @price = product['price']
    @category = product['category']
    @brand,@model = @name.split(" ",2)
    @brand_name = @brand
    @brand.downcase!
    @source = self.class.name
  end

private
  def debug
    puts @name, @code, @url, @category, @brand, @model, @price
  end

end
