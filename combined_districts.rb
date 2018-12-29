#the purpose of this program is to quickly and easily survey local school district employment boards
#and find jobs relevant to the nonprofit One City Project
#to enable One City Project Board President John Compton to connect those the nonprofit mentors to relevant jobs

require 'open-uri'
require 'Nokogiri'
require 'date'
require 'pry'

TEXT_FILES_PATH = ""
ONECITY_FILE = TEXT_FILES_PATH + "one_city_jobs.txt"
ALL_DISTRICTS_FILE = TEXT_FILES_PATH + "all_districts_test.txt"


def get_district_jobs(url, hash, url_starter)
  page = Nokogiri::HTML(open(url))
  links = page.css("a")

  links.each do |link|
    hash[link.text] = url_starter + link["href"].to_s
  end
end

def test_jobs(hash, district_name)
  test_jobs = {} #set up a test in case all one city jobs return nothing
  
  test_keywords = [
    { "include" => ["paraeducator"],
      "exclude" => ["substitute", "special"]
    },
    { "include" => ["spanish"],
      "exclude" => []
    }
  ]
  
  hash.each do |job_title, url|
    test_keywords.each do |include_exclude_hash|
      passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
      fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
      if passes && !fails
        test_jobs[job_title] = url
      end
    end
  end
  
  d = DateTime.now
  
  File.open(ALL_DISTRICTS_FILE, "a") do |file|
    if test_jobs.empty?
      file.puts "#{district_name} school district test failed at #{d.strftime("%d/%m/%Y %H:%M")}."
    else
    file.puts "Test jobs as of #{d.strftime("%d/%m/%Y %H:%M")}: #{district_name} school district."
    test_jobs.each do |title, url|
      file.puts "Job: #{title}. \n Learn more at #{url} \n \n"
    end
    end
  end
  
if test_jobs.empty?
  puts "Program may be broken for the #{district_name} school district."
end
  
end

def one_city_jobs(hash, school_district)
  one_city_keywords = [
  { #dual language teaching
    "include" => ["dual"],
    "exclude" => ["spanish"]
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
    "include" => ["para", "ell"],
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
    "exclude" => ["interpreter", "translator", "spanish"] #don't want interpreter or translator jobs or spanish jobs
  }
]

one_city_jobs = {} #create an empty hash for relevant jobs

hash.each do |job_title, url|
  one_city_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes && !fails
      one_city_jobs[job_title] = url
    end
  end
end

d = DateTime.now

if one_city_jobs.empty?
  puts "No One City jobs in the #{school_district} school district right now. Check back later. \n\n"
else
  puts "Some of the jobs in the #{school_district} district include: \n\n"
  one_city_jobs.each_key do |job_title|
    puts job_title
    puts "\n"
  end
  puts "Check the file #{ONECITY_FILE} for more information. \n\n"
end

File.open(ONECITY_FILE, "a") do |file|
if one_city_jobs.empty?
  file.puts "There are no One City jobs in the #{school_district} school district as of #{d.strftime("%d/%m/%Y %H:%M")}. \n\n"
else  
  file.puts "These are the One City jobs at the #{school_district} School District as of #{d.strftime("%d/%m/%Y %H:%M")}: \n \n"
  one_city_jobs.each do |title, url|
    file.puts "#{title}. \n Learn more at #{url} \n \n"
  end
end
end
end

files = [ALL_DISTRICTS_FILE, ONECITY_FILE]

def clear_files(files_array)
  files_array.each do |f|
    File.open(f, "w") do |file|
      file.truncate(0)
    end
  end
end

#wil not be able to do the following districts: edmonds, everett, tacoma

districts = {
  "Kent" =>
    {"district_name" => "Kent",
      "url" => "https://kent.tedk12.com/hire/index.aspx",
      "url_starter" => "https://kent.tedk12.com/hire/"
  },
   "Highline" =>
       {"district_name" => "Highline",
      "url" => "https://jobs.highlineschools.org/jobs?page_size=250&page_number=1&sort_by=headline&sort_order=ASC",
      "url_starter" => "https://jobs.highlineschools.org"
  },
  "Bellevue" =>
  {"district_name" => "Bellevue",
    "url" => "https://bsd405.tedk12.com/hire/index.aspx",
    "url_starter" => "https://bsd405.tedk12.com/hire/"
  }
}

clear_files(files)

districts.each do |district, information|
  all_district_jobs = Hash.new #all jobs in a single districti
  get_district_jobs(districts[district]["url"], all_district_jobs, districts[district]["url_starter"])
  #binding.pry
  test_jobs(all_district_jobs, districts[district]["district_name"])
  one_city_jobs(all_district_jobs, districts[district]["district_name"])
end
