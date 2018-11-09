#the purpose of this program is to quickly and easily survey local school district employment boards
#and find jobs relevant to the nonprofit One City Project
#to enable One City Project Board President John Compton to connect those the nonprofit mentors to relevant jobs

require 'open-uri'
require 'Nokogiri'
 #these will allow ruby to read and parse the html

page = Nokogiri::HTML(open('https://jobs.highlineschools.org/jobs?page_size=250&page_number=1&sort_by=headline&sort_order=ASC'))
links = page.css("a")

all_highline_jobs = Hash.new
#this time will try using a hash instead of an array

links.each do |link|
  all_highline_jobs[link.text] = "https://jobs.highlineschools.org" + link["href"].to_s
end

test_jobs = {} #set up a test in case all one city jobs return nothing

test_keywords = [
  { "include" => ["paraeducator"],
    "exclude" => ["substitute"]
  },
  { "include" => ["spanish"],
    "exclude" => []
  }
]

all_highline_jobs.each do |job_title, url|
  test_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes & !fails
      test_jobs[job_title] = url
    end
  end
end

File.open("highline_test.txt", "w") do |file|
  if test_jobs.empty?
    file.puts "Highline school district test failed."
  else
  file.puts "Test jobs: Highline school district."
  test_jobs.each do |title, url|
    file.puts "Job: #{title}. \n Learn more at #{url} \n \n"
  end
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

all_highline_jobs.each do |job_title, url|
  one_city_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes & !fails
      one_city_jobs[job_title] = url
    end
  end
end

File.open("highline.txt", "w") do |file|
if one_city_jobs.empty?
  file.puts "There are no One City jobs in the Highline school district. \n\n"
else  
  file.puts "These are the One City jobs at the Highline School District:"
  one_city_jobs.each do |title, url|
    file.puts "#{title}. \n Learn more at #{url} \n \n"
  end
end
end


