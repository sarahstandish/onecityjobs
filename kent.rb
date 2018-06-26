#The purpose of this file is to try to do the same as I did for the highline school district
#but with the Kent school district

require 'open-uri'
require 'Nokogiri'

#open the Kent school district jobs page
content = open('https://kent.tedk12.com/hire/index.aspx')


parsed_content = Nokogiri::HTML(content)

# puts parsed_content.css('#JobList_1')


i = 0
5.times do
  puts parsed_content.css('#JobList_#{i}')
  i += 1
end
# this seems like an ineffecient way of going through these...there must be a better way...



# note: use . for classes and # for ids
#.css('.panelContent')

#.css('.content')
