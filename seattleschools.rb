#starting a file to parse seattle schools web page 

require 'open-uri'
require 'Nokogiri'

content = open('https://www.governmentjobs.com/careers/seattleschools/')

parsed_content = Nokogiri::HTML(content)

parsed_content.css('.listing-title').css('.list-item')



