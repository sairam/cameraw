class SmartShopperHTMLScraper < HTMLScraper
  @@compacts = "http://www.smartshoppers.in/category/best-digital-cameras/offset0/&cboPagingLimit=2000"
  @@lenses = "http://www.smartshoppers.in/category/photography-lenses/offset0/&cboPagingLimit=2000"
  @@slrs = "http://smartshoppers.in/category/slr-digital-cameras/offset0/&cboPagingLimit=2000"
  @@camcorders = "http://smartshoppers.in/category/best-digital-camcorders/offset0/&cboPagingLimit=2000"
  def initialize
    @urls = {"slrs" => @@slrs, "lenses" => @@lenses, "compacts" => @@compacts, "camcorders" => @@camcorders}
    @complete_data = []
    @filename = SmartShoppersConfig::Filename
    @per_page = 3000
    @base_url = "http://smartshoppers.in/"

    @total_count = ""
    @product_details = "form.product_brief_block"
  end

private
  def get_page_count(page)
    # everything comes in a single page
    -1
  end
  def parse_data product_section
    print "."
    ab = product_section.xpath('table/tr[1]/td/div/a')
    abc = if ab.size > 1
      ab[1]
    elsif ab.size == 1
      ab[0]
    else
      fail "could not parse data"
    end
    {
    'url' =>  @base_url + abc.attr('href'),
    'image' => product_section.xpath('table/tr[1]/td/div/a/img').attr('src').value,
    'name' => product_section.xpath('table/tr[1]/td/div/a/img').attr('alt').value,
    'price' => product_section.css('div.prdbrief_price').text().split(" ")[-1].gsub(/Rs\.?/,'').gsub(',','').strip.to_f,
    }
  end

end
