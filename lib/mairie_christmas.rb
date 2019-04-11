require 'pry'
require 'nokogiri'
require 'open-uri'

### URL = liste des communes du département
source = 'https://www.annuaire-des-mairies.com/val-d-oise.html'
page = Nokogiri::HTML(open(source))
urls = page.css('p').css('a.lientxt')
urls_array = []
city_array = []
emails_array = [] #En dehors de la boucle
final_array = []
urls.each do |urls|
  urls_array << urls['href']
  city_array << urls.text
end

#Transformation en url absolues
urls_array.map! {|url|
  url = 'https://www.annuaire-des-mairies.com/val-d-oise.html'  + '/.' + url
}

# puts urls_array

## URL = page de mairie
urls_array.each {|adresse|
  page = Nokogiri::HTML(open(adresse))
  emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  emails.each do |line|
    puts line.text
    emails_array << line.text
  end
}

print emails_array.length , "=", city_array.length, "\n"

n=0
city_array.each do |cell|
  final_array << {cell => emails_array[n]}
  n += 1
end

puts final_array
puts final_array.length
# binding.pry