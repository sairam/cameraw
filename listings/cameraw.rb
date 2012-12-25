
class Cameraw < Sinatra::Base

set :slim, :format => :html5
# set :server, 'thin'

set :threaded, true

configure do
  enable :logging
end

# list all camera companies
get '/store/?' do
  @categories = MainLinks.categories_with_count
  @brands = MainLinks.brands_with_count
  slim :index
end

get '/search/*' do |search|
  slim :listpage
end

# category/kodak, cameras/kodak
# display camera / required pages
get '/store/:category/?' do |category|
  @category = category
  @brands = MainLinks.filter_brands_by_categories(@category)
  slim :category_list
end
get '/store/cameras/:brand/?' do |brand|
  @brand = brand
  @models = MainLinks.filter_by_brands([brand])
  slim :brand_list
end
get '/store/:category/:brand/?' do |category, brand|
  @category,@brand = category, brand
  @models = MainLinks.filter_by_category_and_brand(@category,@brand)
  slim :category_brand_list
end
get '/store/:category/:brand/:code' do |category, brand, code|
  @category,@brand,@code = category, brand, code
  @product = MainLinks.get_product_by_code(@code)
  slim :product_page
end

# redirect from our site to the store
get '/store/:store' do |store|
end

# redirect from our site to the direct link
get '/store/buy/:link' do |link|
end

not_found do
  halt 404, 'page not found'
end

helpers do
  def category_brand_product_url(product)
    "/store/#{product.category}/#{product.brand}/#{product.code}"
  end
  def category_brand_url(category, brand)
    "/store/#{category}/#{brand}"
  end
  def brand_url(brand)
    "/store/cameras/#{brand}"
  end
  def category_url(category)
    "/store/#{category}"
  end
end


end