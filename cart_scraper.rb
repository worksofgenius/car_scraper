# cart_scraper.rb
require 'kimurai'

class CartScraper < Kimurai::Base
  @name = 'cart_scraper'
  @engine = :mechanize
  @start_urls = ['https://kitchencars-japan.com/pages/cars']
  @config = {
    user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36',
    before_request: { delay: 4..7 },
    encoding: 'UTF-8'
  }

  def parse(response, url:, data: {})
    response.xpath("//div[@class='p-car']").each do |a|
      request_to :parse_repo_page, url: absolute_url(a[:href], base: url)
    end

    if next_page = response.at_xpath("//a[@class='page-link']")
      request_to :parse, url: absolute_url(next_page[:href], base: url)
    end
  end

  def parse_repo_page(response, url:, data: {})
    item = {}

    item[:name] = response.xpath("//div[@class='p-car__name']//h4").text
    item[:area] = response.xpath("//div[contains(@class,'p-car__info__area')]").text
    item[:type] = response.xpath("//div[contains(@class,'p-car__info__type')]").text
    item[:food] = response.xpath("//div[contains(@class,'p-car__info__food')]").text
    item[:base] = response.xpath("//div[contains(@class,'p-car__info__base')]").text

    save_to 'results.json', item, format: :pretty_json
  end
end

CartScraper.crawl!
