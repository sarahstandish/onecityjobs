#starting a file to parse seattle schools web page

require 'open-uri'
require 'Nokogiri'

page = Nokogiri::HTML(open('https://www.governmentjobs.com/careers/seattleschools?sort=PositionTitle%7CAscending'))
links = page.css('#main-container')



print links

=begin
all_sps_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
  all_sps_jobs[link.text] = link["href"]
end
=end

=begin

content = open('https://www.governmentjobs.com/careers/seattleschools?sort=PositionTitle%7CAscending')

parsed_content = Nokogiri::HTML(content)

puts parsed_content

#.css('#main-container') - gave me...something, but no jobs

# note: use . for classes and # for ids
# use .count to find out how many objects there are
# watching: https://www.youtube.com/watch?v=1UYBAn69Qrk
# .text - pull the text out of a nokogiri element
=end
