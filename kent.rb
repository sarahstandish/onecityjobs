#The purpose of this file is to try to do the same as I did for the highline school district
#but with the Kent school district

require 'open-uri'
require 'Nokogiri'

#here is my second try based on info found in http://ruby.bastardsbook.com/chapters/html-parsing/

page = Nokogiri::HTML(open('https://kent.tedk12.com/hire/index.aspx'))
links = page.css("a")
#links = page.css('#JobList').css("a")

all_kent_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
  all_kent_jobs[link.text] = "https://kent.tedk12.com/hire/" + link["href"].to_s
end

=begin
all_kent_jobs.each do |title, url|
  puts "Job: #{title}. Learn more at https://kent.tedk12.com/hire/#{url}"
end
=end



test_jobs = {} #set up a test in case all onecity jobs return nothing

test_keywords = [
  { "include" => ["paraeducator"],
    "exclude" => ["substitute"]
  },
  { "include" => ["spanish"],
    "exclude" => []
  }
]

all_kent_jobs.each do |job_title, url|
  test_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes & !fails
      test_jobs[job_title] = url
    end
  end
end

File.open("kent_test.txt", "w") do |file|
  test_jobs.each do |title, url|
    file.puts "Job: #{title}. \n #{url} \n \n"
  end
end

one_city_keywords = [
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

one_city_jobs = {} #create an empty hash for relevant jobs

all_kent_jobs.each do |job_title, url|
  one_city_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes & !fails
      one_city_jobs[job_title] = url
    end
  end
end

File.open("kent.txt", "w") do |file|
if one_city_jobs.empty?
  file.puts "There are no One City jobs in the Kent school district right now."
else  
  file.puts "These are the One City jobs:"
  one_city_jobs.each do |title, url|
    file.puts "Job: #{title}. /n Learn more at https://kent.tedk12.com/hire/#{url} /n /n"
  end
end
end


