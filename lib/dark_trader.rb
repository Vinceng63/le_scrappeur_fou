
require 'rubygems'
require 'rspec'
require 'pry'
require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
row = page.css('div.table-responsive.compact-name-column table#currencies-all tr')


cryptos = [] # ou Array.new      Ici j'ai mis les déclarations des tableaux en dehors de la boucle qui commence après
price_array = [] # ou Array.new
symbol_array = [] # ou Array.new
### Isoler les bons éléments HTML
row.each do |row|
 symbol = row.css('td.text-left.col-symbol')
 price = row.css('td.no-wrap.text-right a.price')

### Array avec les symboles
symbol.each do |symbol|
  symbol_array << symbol.text
end

### Array avec les prix
price.each do |price|
 price_array << price.text.delete_prefix("$").to_f.round(7) #J'ai mis 7 pour avoir plein de chiffres après la virgules
end



end #fin de la boucle row.each do

n=0
symbol_array.each do |cell| #On parcourt les 2 tableaux l'un avec la variable cell et l'autre avec n
  cryptos << {cell => price_array[n]}
  n+=1
end


puts cryptos
