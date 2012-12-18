=begin
Expects a product with brand_name, category
=end

class PriceReader
  attr_accessor :filename, :products
  def initialize
    @products = []
  end

  def extract_brand(str, klass)
    if klass.name == DPReview
      # products.map
      return ""
    end
  end

  def brands
    (@products.map{|p| p.brand_name}).uniq
  end
  def brands_with_count
    @products.inject(Hash.new(0)) {|h,p| h[p.brand_name] += 1; h }
  end

  def categories
    (@products.map{|p| p.category}).uniq
  end
  def categories_with_count
    @products.inject(Hash.new(0)) {|h,p| h[p.category] += 1; h }
  end

  def filter_by_categories(categories)
    (@products.select{|p| categories.include?(p.category)})
  end

  def filter_by_brands(brands)
    (@products.select{|p| brands.include?(p.brand_name)})
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

private
  def debug
    puts @name, @code, @url, @category, @brand, @model
  end

end
