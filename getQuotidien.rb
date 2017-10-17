#!/usr/bin/ruby
require 'rubygems'
require 'nokogiri' 

date = Time.now
day = date.day
raw_month = date.month
year = date.year
monthString = ["janvier", "fevrier", "mars", "avril", "mai", "juin", "juillet", "aout", "septembre", "octobre", "novembre", "decembre"]

month = monthString[raw_month-1]

url_first = "https://www.tf1.fr/tmc/quotidien-avec-yann-barthes/videos/quotidien-premiere-partie-#{day}-#{month}-#{year}.html"
puts url_first
url_second = "https://www.tf1.fr/tmc/quotidien-avec-yann-barthes/videos/quotidien-deuxieme-partie-#{day}-#{month}-#{year}.html"
puts url_second

%x(curl #{url_first} > quotidien-first.html)
%x(curl #{url_second} > quotidien-second.html)

first = Nokogiri::HTML(open("quotidien-first.html")).xpath('//div[@id="zonePlayer"]/@data-src').first.value[2..-1]

second = Nokogiri::HTML(open("quotidien-second.html")).xpath('//div[@id="zonePlayer"]/@data-src').first.value[2..-1]

puts "Opening first part URL : #{first}"
%x(firefox #{first})
puts "Opening second part URL : #{second}"
%x(firefox #{second})

# cleaning
%x(rm quotidien-first.html)
%x(rm quotidien-second.html)
