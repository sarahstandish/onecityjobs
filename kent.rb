#The purpose of this file is to try to do the same as I did for the highline school district
#but with the Kent school district

require 'open-uri'
require 'Nokogiri'

#open the Kent school district jobs page
content = open('https://kent.tedk12.com/hire/index.aspx')


parsed_content = Nokogiri::HTML(content)

puts parsed_content.css('.content').css('.panelContent').css('.DynaListGeneric').inner_html
