#The purpose of this file is to try to do the same as I did for the highline school district
#but with the Kent school district

require 'open-uri'
require 'Nokogiri'

#here is my second try based on info found in http://ruby.bastardsbook.com/chapters/html-parsing/

page = Nokogiri::HTML(open('https://kent.tedk12.com/hire/index.aspx'))
links = page.css('#JobList').css("a")

all_kent_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
#  puts link.text
#  puts "*****"
#  puts link["href"]
#  puts "-----"
  all_kent_jobs[link.text] = link["href"]
end

all_kent_jobs.each do |title, url|
  puts "Job: #{title}. Learn more at https://kent.tedk12.com/hire/#{url}"
end

=begin
# going to make this all a comment
# so I can try something else
# this was my old work, which didn't work so well 

#open the Kent school district jobs page
content = open('https://kent.tedk12.com/hire/index.aspx')

kent_content = Array.new

parsed_content = Nokogiri::HTML(content)

parsed_content.css('#JobList').css('.rowA').each do |item|
  kent_content.push(item.to_s)
end

parsed_content.css('#JobList').css('.rowB').each do |item|
  kent_content.push(item.to_s)
end

kent_content.each do |item|
  puts item
  puts "------------------"
end

all_jobs = Array.new
relevant_jobs = Array.new
kent_relevant_content = Array.new

kent_content.each do |item|
  link = item['href'].to_s
  all_jobs.push(link)
end

puts all_jobs


keywords = [
  { #dual language teaching
    "include" => ["dual"],
    "exclude" => []
  },
  { #vietnamese
    "include" => ["viet"],
    "exclude" => []
  },
  { #bilingual paraeducator
    "include" => ["bi", "para"],
    "exclude" => []
  },
  { #ELL paraeducator
    "include" => ["para", "ELL"],
    "exclude" => []
  },
  { #arabic
    "include" => ["arab"],
    "exclude" => []
  },
  { #somali
    "include" => ["somal"],
    "exclude" => []
  },
  { #tagolog
    "include" => ["tagalog"],
    "exclude" => []
  },
  { #russian
    "include" => ["russ"],
    "exclude" => []
  },
  { #cantonese
    "include" => ["canton"],
    "exclude" => []
  },
  { #bilingual paraeducator
    "include" => ["bilin"],
    "exclude" => ["interpreter", "translator", "Spanish"] #don't want interpreter or translator jobs or spanish jobs
  }
]
=end

=begin
kent_content.each do |job|
  keywords.each do |hash|
    passes = hash["include"].all? { |word| job.include?(word) }
    fails  = hash["exclude"].any? { |word| job.include?(word) }
    if passes && !fails #contains any of the included words and none of the excluded words]
      kent_relevant_content.push(job)
    end
  end
end
=end

=begin
puts kent_content.length
puts kent_relevant_content.length
puts all_jobs.length
= end

# video to keep watching: https://www.youtube.com/watch?v=1UYBAn69Qrk

# parsed_content.split(/href/)

# note: use . for classes and # for ids
#.css('.panelContent')

#.css('.content')

#tried: .split(" "), undefined method

=begin
Here is a different keywords array I made to test if it's working
Because my other keywords could easily return zero
keywords = [
  {
    "include" => ["elementary"],
    "exclude" => []
  },
  {
    "include" => ["music"],
    "exclude" => []
  }
]
=end
