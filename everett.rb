require 'open-uri'
require 'Nokogiri'

page = Nokogiri::HTML(open('https://www.applitrack.com/everettsd/onlineapp/default.aspx?all=1'))
links = page.css('.box-indent')

puts links

=begin
print links.length

links.each do |link|
  puts link
  puts "------------"
end
=end

=begin
all_everett_jobs = Hash.new

links.each do |link|
  all_everett_jobs[link.text] = link["href"]
end

print all_everett_jobs
=end

=begin
test_jobs = {} #set up a test in case all one city jobs return nothing

test_keywords = [
  { "include" => ["paraeducator"],
    "exclude" => ["substitute"]
  },
  { "include" => ["spanish"],
    "exclude" => []
  }
]

all_everett_jobs.each do |job_title, url|
  test_keywords.each do |include_exclude_hash|
    passes = include_exclude_hash["include"].all? { |word| job_title.downcase.include?(word) }
    fails = include_exclude_hash["exclude"].any? { |word| job_title.downcase.include?(word) }
    if passes & !fails
      test_jobs[job_title] = url
    end
  end
end

File.open("everett_test.txt", "w") do |file|
  if test_jobs.empty?
    file.puts "Everett school district test failed."
  else
  file.puts "Test jobs: Everett school district."
  test_jobs.each do |title, url|
    file.puts "Job: #{title}. \n Learn more at #{url} \n \n"
  end
  end
end
=end