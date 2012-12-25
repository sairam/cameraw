
class FlipkartHTMLScraper < HTMLScraper

  def initialize
    @urls = {'none' => 'http://www.flipkart.com/cameras/pr?sid=jek%2Cp31&layout=list&start=START', 'lenses' => 'http://www.flipkart.com/cameras-accessories/lenses/pr?sid=jek%2C6l2%2Ce9y&layout=list&start=START'}

    @complete_data = []
    @per_page = 20
    @filename = FlipkartConfig::Filename

    @product_details = "div.browse-product"
    @total_count = "div#searchCount span.items"
  end

private
  def get_page_count(page)
    page.css(@total_count).text()
  end

  def get_title product_section
    product_section.css("div.product-ugc-summary div.fk-stars-small")[0]['title']
  rescue
    ""
  end
  def get_price product_section
    product_section.css("div.fk-srch-pricing strong.price.final-price").text().strip.gsub(/Rs\.?/,'').gsub(',','').strip
  rescue
    ""
  end

  def parse_data product_section
    print "."
    image_section = product_section.css("div.fk-sitem-image-section a")
    {
    'url' => "http://www.flipkart.com"+image_section[0]['href'], # link
    'image' => image_section.children().first['src'], # image
    'name' => image_section.children().first['alt'], # text
    'review_info' => product_section.css("div.product-ugc-summary").text().gsub(/\s/,''), # no of ratings and reviews
    'rating_info' => get_title(product_section), # title - for stars / rating
    'price' => get_price(product_section), # price section
    }
  end

end