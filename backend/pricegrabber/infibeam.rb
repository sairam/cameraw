

class InfibeamHTMLScraper < HTMLScraper
  def initialize
    @urls = ["http://www.infibeam.com/Cameras/Search_ajax.action?store=Cameras&page=PAGE"]

    @complete_data = []
    @per_page = 20
    @filename = InfibeamConfig::Filename

    @total_count = "div.resultsSummary b[2]"
    @product_details = "ul.srch_result li"
  end

private
  def get_page_count(page)
    page.css(@total_count).first.text()
  end

  def parse_data(product_section)
    print "."
    {
    'url' => "http://www.infibeam.com/"+product_section.css('a').attr('href').value,
    'image' => product_section.css('a img').attr('src').value,
    'name' => product_section.css('a').attr('title').value,
    'price' => product_section.css('div.price span.normal').text().gsub(',','').strip, # price section
    # add out of stock / availability information
    }
  end

end