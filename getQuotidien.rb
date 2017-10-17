#!/usr/bin/ruby
require 'rubygems'
require 'nokogiri' 

date = Time.now
day = date.day
year = date.year
error = "Error - Abort"

url = "https://www.tf1.fr/tmc/quotidien-avec-yann-barthes/videos/quotidien-premiere-partie-#{day}-octobre-#{year}.html"

html = %x(curl #{url} > quotidien.html)

if html.empty?
  puts error
end
page = Nokogiri::HTML(open("quotidien.html"))
doc = page.xpath('//div[@id="zonePlayer"]/@data-src').first.value[2..-1]

puts "Opening URL : #{doc}"
%x(firefox #{doc})

# cleaning
%x(rm quotidien.html)
