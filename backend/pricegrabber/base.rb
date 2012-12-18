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
        data = scrape_from(url).flatten.map do |x|
          x['category'] = category
          x
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
    start = 1
    no_of_times = 1
    complete_data = []

    page = Nokogiri::HTML(open(url.gsub('PAGE',no_of_times.to_s).gsub('START',start.to_s)).read)
    no_of_pages = (get_page_count(page).to_f / per_page).ceil

    # Get first page data
    complete_data << page.css(@product_details).map do |product_section|
      parse_data(product_section)
    end

    while no_of_times < no_of_pages
      start = no_of_times * @per_page + 1
      no_of_times += 1
      page = Nokogiri::HTML(open(url.gsub('PAGE',no_of_times.to_s).gsub('START',start.to_s)).read)
      sleep 1
      complete_data << page.css(@product_details).map do |product_section|
        parse_data product_section
      end
    end
    complete_data
  end

end

