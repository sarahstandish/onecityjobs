require 'open-uri'
require 'Nokogiri'
 #these will allow ruby to read and parse the html

page = Nokogiri::HTML(open('https://www2.nwrdc.wa-k12.net/scripts/cgiip.exe/WService=wedmonds71/rapplmnu03.w'))
links = page.css("a")

print page

=begin

all_edmonds_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
  all_edmonds_jobs[link.text] = "https://www2.nwrdc.wa-k12.net/scripts/cgiip.exe/WService=wedmonds71/rapplmnu03.w"
end
=end