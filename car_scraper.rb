#car_scraper.rb
require 'kimurai'

class CarScraper < Kimurai::Base
  @name = 'kitchen_car_scraper'
  @start_urls = ['https://kitchencars-japan.com/pages/cars/search?_token=8HG7oZU4RnkbyuNZtHScA2RmzVqcs32fnxNEU23m&prefecture=13&genre=&country=&car_type=&free_word=']
  @engine = :mechanize
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 4..7 },
    encoding: "UTF-8"
  }

  @@cars = []

  def scrape_car_details
    web_page = browser.current_response
    car_list = web_page.css('div.row')
    car_list.css('div.p-car').each do |char_element|
      name = char_element.css('div.p-car__name h4').text.gsub(/\n/, "")
      area = char_element.css('div.p-car__info__area').text.gsub(/\n/, "")
      type = char_element.css('div.p-car__info__type').text.gsub(/\n/, "")
      food = char_element.css('div.p-car__info__food').text.gsub(/\n/, "")
      base = char_element.css('div.p-car__info__base').text.gsub(/\n/, "")
      car_details = [name, area, type, food, base]
      @@cars << car_details if !@@cars.include?(car_details)
    end
  end

  def parse(response, url:, data: {})
    scrape_car_details

    CSV.open('carData.csv', 'w') do |csv|
      @@cars.each { |element| csv.puts(element) }
    end

    @@cars
  end
end

CarScraper.crawl!
