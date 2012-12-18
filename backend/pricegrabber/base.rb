# Basic methods
#   save info into file and compare with older version for count
class BasicPriceGrabber
  attr_accessor :filename

  def initialize
    fail "Not allowed"
  end

  # save the array of complete_data in yaml
  def save
    begin
      file = open(@filename,'r')
      old_data = YAML::load file.read
      file.close
      puts "There are #{(@complete_data - old_data).size} new products"
    rescue
    end

    file = open(@filename,'w+')
    file.write @complete_data.to_yaml
    file.close
  end
end


class HTMLScraper < BasicPriceGrabber
  attr_accessor :complete_data, :per_page, :total_count, :product_details

  def perform
    if @urls.class == Array
      @complete_data = @urls.map do |url|
        scrape_from(url)
      end.flatten
    elsif @urls.class == Hash
      @urls.each do |category, url|
        if url.class == Array
          data = url.map{|aurl| scrape_from(aurl)}.flatten.map do |x|
            x['category'] = category
            x
          end
        else
          data = scrape_from(url).flatten.map do |x|
            x['category'] = category
            x
          end
        end
        @complete_data << data
      end
      @complete_data.flatten!
    end
    save
  end

private
  def initialize
    fail "Not allowed"
  end

  def scrape_from(url)
    start = 0
    start_offset = 0
    no_of_times = 1
    complete_data = []

    myurl = url.gsub('PAGE',no_of_times.to_s).gsub('START_OFFSET',start_offset.to_s).gsub('START',start.to_s)
    # puts myurl
    page = Nokogiri::HTML(open(myurl).read)
    no_of_pages = (get_page_count(page).to_f / per_page).ceil

    # Get first page data
    complete_data << page.css(@product_details).map do |product_section|
      parse_data(product_section)
    end

    while no_of_times < no_of_pages
      start_offset = no_of_times * @per_page
      # puts start_offset
      start = no_of_times * @per_page + 1
      no_of_times += 1
      myurl = url.gsub('PAGE',no_of_times.to_s).gsub('START_OFFSET',start_offset.to_s).gsub('START',start.to_s)
      # puts myurl
      page = Nokogiri::HTML(open(myurl).read)
      sleep 1
      complete_data << page.css(@product_details).map do |product_section|
        parse_data product_section
      end
    end
    complete_data
  end

end

=begin
class MyHTMLScraper < HTMLScraper
  @@compacts = ""
  @@camcoders = ""
  @@slrs = ""

  def initialize
    @urls = {"slrs" => @@slrs, "camcoders" => @@camcoders, "compacts" => @@compacts}
    @complete_data = []
    @filename = MyConfig::Filename
    @per_page = 30

    @total_count = "span.blue"
    @product_details = "div#results .product-block1"
  end

private
  def get_page_count(page)
    page.css(@total_count).text().match(/^(.+) products/)[1]
  end
  def parse_data product_section
    print "."
    {
    'url' => product_section.css(' > a').attr('href').value,
    'image' => product_section.css('div.pro-block a img').attr('src').value,
    'name' => product_section.css('div.pro-block a img').attr('alt').value,
    'price' => product_section.css(' > a').text().strip.gsub(/Rs\.?/,'').gsub(',','').strip, # price section
    }
  end

end
=end
