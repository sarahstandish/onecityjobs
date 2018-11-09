require 'open-uri'
require 'Nokogiri'
 #these will allow ruby to read and parse the html

page = Nokogiri::HTML(open('https://tps10prod-lm01.cloud.infor.com:1444/lmghr/CandidateSelfService/controller.servlet?context.dataarea=lmghr&context.session.key.JobBoard=CERTIFICATED&context.session.key.HROrganization=10#'))
links = page.css("a")

print page

print links

all_tacoma_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
  all_tacoma_jobs[link.text] = "https://tps10prod-lm01.cloud.infor.com:1444/lmghr/CandidateSelfService/controller.servlet?context.dataarea=lmghr&context.session.key.JobBoard=CERTIFICATED&context.session.key.HROrganization=10#"
end