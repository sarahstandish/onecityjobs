#starting a file to parse seattle schools web page

require 'open-uri'
require 'Nokogiri'


content = open('https://www.governmentjobs.com/careers/seattleschools?sort=PositionTitle%7CAscending')

parsed_content = Nokogiri::HTML(content)

puts parsed_content

#.css('#main-container') - gave me...something, but no jobs

# note: use . for classes and # for ids
# use .count to find out how many objects there are
# watching: https://www.youtube.com/watch?v=1UYBAn69Qrk
# .text - pull the text out of a nokogiri element
