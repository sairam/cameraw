class IndiaPlazaHTMLScraper < HTMLScraper

  @@slrs = "http://www.indiaplaza.com/dslr-cameras-cameras-1.htm?sort=dp&PageNo=PAGE"
  @@compacts = "http://www.indiaplaza.com/camera-lenses-cameras-1.htm?sort=dp&PageNo=PAGE"
  @@lenses = "http://www.indiaplaza.com/camera-lenses-cameras-1.htm?sort=dp&PageNo=PAGE"

  def initialize
    @urls = {"slrs" => @@slrs, "lenses" => @@lenses, "compacts" => @@compacts}
    @complete_data = []
    @filename = IndiaPlazaConfig::Filename
    @per_page = 20
    @base_url = "http://www.indiaplaza.com"

    @total_count = "div.prodNoArea"
    @product_details = "div.skuRow"
  end

private
  def get_page_count(page)
    page.css(@total_count).text().match(/([0-9]+) products/)[1]
  end
  def parse_data product_section
    print "."
    {
    'url' => @base_url + product_section.css('div.skuImg > a').attr('href').value,
    'image' => product_section.css('div.skuImg a img').attr('src').value,
    'name' => product_section.css('div.skuImg > a img').attr('alt').value,
    'price' => product_section.css('div.ourPrice').text().strip.split(":")[1].gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end
