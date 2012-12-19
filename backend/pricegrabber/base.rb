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

  def compute_url(url, no_of_times)
    no_of_times -= 1
    start_offset = no_of_times * @per_page
    start = no_of_times * @per_page + 1
    no_of_times += 1

    url.gsub('PAGE',no_of_times.to_s).gsub('START_OFFSET',start_offset.to_s).gsub('START',start.to_s)
  end

  def scrape_from_page(page)
    fail "Override this method"
  end
  def get_page_data(url)
    fail "Override this method"
  end

private
  def wait
    sleep 1
  end
end


class HTMLScraper < BasicPriceGrabber
  attr_accessor :complete_data, :per_page, :total_count, :product_details

  def perform
    @urls = {"none" => @urls} if @urls.class == Array || @urls.class == String

    if @urls.class == Hash
      @urls.each do |category, url|

        url = [url] unless url.class == Array

        data = url.map{|aurl| scrape_from(aurl)}.flatten

        unless category == "none"
          data.map! do |x|
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
    complete_data = []
    no_of_times = 0
    begin
      no_of_times += 1
      page = get_page_data( compute_url(url,no_of_times) )
      no_of_pages = (get_page_count(page).to_f / per_page).ceil if no_of_times == 1
      wait
      complete_data << scrape_from_page(page)
    end while no_of_times < no_of_pages

    complete_data
  end

  # Can be overriden
  def scrape_from_page(page)
     page.css(@product_details).map do |product_section|
      parse_data(product_section)
    end
  end

  # Can be overriden
  def get_page_data(url)
    Nokogiri::HTML(open(url).read)
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
