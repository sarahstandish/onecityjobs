#the purpose of this program is to quickly and easily survey local school district employment boards
#and find jobs relevant to the nonprofit One City Project
#to enable One City Project Board President John Compton to connect those the nonprofit mentors to relevant jobs

require 'open-uri'
require 'Nokogiri'
 #these will allow ruby to read and parse the html

#open the url
content = open('https://jobs.highlineschools.org/jobs?page_size=250&page_number=1&sort_by=headline&sort_order=ASC')

#this is how we parse it, we create a new variable called parsed_content
#then we pass the variable already created called parsed_content
#into nokogiri
parsed_content = Nokogiri::HTML(content)
#this processed different nodes with a nokogiri wrapper
#this makes the html into a ruby object

#this would return only the "item title" that appears under a "result item"
#not sure how useful it is for my purposes but just trying it out
parsed_content.css('.result-item').css('.item-title')
#i'm not 100% on the content above, just mainly following along with the video I watched there

#create an array where I will eventually store my relevant jobs. Also, an array for all jobs.
all_jobs = Array.new
relevant_jobs = Array.new

#here's a loop that just prints the links
parsed_content.css('.result-item').css('.item-title').each do |row|
  link = row['href'].to_s #the key to making this work was converting it to a string. I dont know what it was before but none of the methods for strings were working.
  if link.length > 1 #I was getting back some blank entries so only going to take those that are longer than one character
  all_jobs.push("https://jobs.highlineschools.org" + link) #add the first part of the url to make it a usable link later
  end
end

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
    "include" => ["para", "ELL"]
    "exclude" => []
  }
  { #arabic
    "include" => ["arab"],
    "exclude" => []
  },
  { #somali
    "include" => ["somal"],
    "exclude" => []
  },
  { #tagolog
    "include" => ["tagolog"],
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


all_jobs.each do |job|
  keywords.each do |hash|
    passes = hash["include"].all? { |word| job.include?(word) }
    fails  = hash["exclude"].any? { |word| job.include?(word) }
    if passes && !fails #contains any of the included words and none of the excluded words]
      relevant_jobs.push(job)
    end
  end
end



puts relevant_jobs #so I can see the progress so far

#put these links in a file
File.open("highline.txt", "w+") do |line|
  line.puts(relevant_jobs)
end

=begin
relevant_jobs.each do |link|
  job_content = open('link')
  job_parsed_content = Nokogiri::HTML(job_content)
  puts job_parsed_content
end
=end

#the following works, so why doesn't the above work?

=begin -- tabling the following for now
job_content = open('https://jobs.highlineschools.org/elem-teacher-dual-language-prog-general-pool/job/8702141')
job_parsed_content = Nokogiri::HTML(job_content)
puts job_parsed_content
=end


=begin Outdated material
# next up: watch this video https://www.youtube.com/watch?v=j9MmyJrmLhI hrm not much interesting there

This is the old way I did it before Duncan suggested the more efficient way above
#check the "all jobs" array for the terms that would indicate they are relevant to John.
#if they are, add them to a the "relevant jobs" array
#i'll shorten them incase they are abbreviated
all_jobs.each do |job|
  if job.include?("dual") #dual-language teaching positions...this will return a lot of false positives, but hard to exclude...
    relevant_jobs.push(job)
  elsif job.include?("viet") #vietnamese
    relevant_jobs.push(job)
  elsif job.include?("bi") && job.include?("para") #bilingual paraeducator
    relevant_jobs.push(job)
  elsif job.include?("arab") #arabic
    relevant_jobs.push(job)
  elsif job.include?("korea") #korean
    relevant_jobs.push(job)
  elsif job.include?("somal") #somali
    relevant_jobs.push(job)
  elsif job.include?("tagalog") #tagolog
    relevant_jobs.push(job)
  elsif job.include?("russia") #russian
    relevant_jobs.push(job)
  elsif job.include?("canton") #cantonese
    relevant_jobs.push(job)
  elsif job.include?("bilin") #bilingual
    unless job.include?("interpreter") #don't want any interpreter jobs
    relevant_jobs.push(job)
    end
  end
end
=end
