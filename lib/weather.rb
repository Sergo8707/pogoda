require 'unicode_utils/downcase'
require 'nokogiri'
require 'open-uri'

class Weather

  def initialize(city)
    @city = UnicodeUtils.downcase(city)
    @uri = "https://pogoda.mail.ru/prognoz/#{@city.gsub(/-/, '_')}"
    @encoded = URI.encode(@uri)
    @url = URI.parse(@encoded)

    begin
      @doc = Nokogiri::HTML(open(@url))
    rescue OpenURI::HTTPError => e
      puts "\nГород не найден"
      abort e.message
    end
  end

  def cln # очищает консоль
    system "clear" or system "cls"
  end

  def weather_in_the_city
    cln
    @whether_now = @doc.xpath("//meta[5]").attr('content')
    puts "#{@whether_now}."
    puts
    counter = 0
    while counter < 9
      date = @doc.xpath("//div[@class='day']/a/div[1]")[counter].text
      whether = @doc.xpath("//div[@class='day']/a/div[@class='day__description']")[counter].text.gsub(/\s+/, '')
      temperature_day = @doc.xpath("//div[@class='day']/a/div[@class='day__temperature']")[counter].text.gsub(/\s+/, '')

      puts "#{date}  #{whether}  температура: #{temperature_day} "
      counter += 1
    end
  end
end