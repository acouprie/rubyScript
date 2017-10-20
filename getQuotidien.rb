# déclarer le fichier comme un fichier ruby
!/usr/bin/ruby
# les gems ruby sont l'équivalent des bibliothèques/librairies
# dans d'autres langages
require 'rubygems'
# nokogiri est une librairie pour découper le html
# plus d'info sur nokogiri : https://rubygems.org/gems/nokogiri
require 'nokogiri'

# Time.now renvoie la date d'aujourd'hui
# en format 2017-10-20 09:15:00 +0200
date = Time.now
# cette ligne est identique à :
# day = Time.now.day
day = date.day
raw_month = date.month
year = date.year
# les fonctions .day .month .year sont déjà implémentées dans ruby
# elle permettent d'extraire l'information de Time.now

# un tableau de mois en lettres
monthString = ["janvier", "fevrier", "mars", "avril", "mai", "juin", "juillet", "aout", "septembre", "octobre", "novembre", "decembre"]

# raw_month est un integer (un nombre) or on veux un mois en lettre
# ainsi cette ligne peut se lire
# month est égal à la case 10-1 (si on est en octobre) de mon tableau monthString
# Pourquoi -1 ? Parce que les tableau en ruby commence à 0 (janvier = 0 / fevrier = 1 ...)
month = monthString[raw_month-1]

# url de la première partie de quotidien avec les variables day, month et year
url_first = "https://www.tf1.fr/tmc/quotidien-avec-yann-barthes/videos/quotidien-premiere-partie-#{day}-#{month}-#{year}.html"
# on affiche l'url dans la console
puts url_first

# url de la deuxieme partie de quotidien avec les variables day, month et year
url_second = "https://www.tf1.fr/tmc/quotidien-avec-yann-barthes/videos/quotidien-deuxieme-partie-#{day}-#{month}-#{year}.html"
# on affiche l'url dans la console
puts url_second

# %x() permet d'executer une commande Linux, dans notre cas curl
# curl est une commande qui permet de ramener le code source
# de la page demandée (exactement le même que dans un navigateur tu fais clic droit > afficher le code source)
# on stocke le code source HTML dans un fichier qui sera automatiquement créé
%x(curl #{url_first} > quotidien-first.html)
%x(curl #{url_second} > quotidien-second.html)

# Nokogiri est un peu complexe je te l'expliquerai à part
first = Nokogiri::HTML(open("quotidien-first.html")).xpath('//div[@id="zonePlayer"]/@data-src').first.value[2..-1]

second = Nokogiri::HTML(open("quotidien-second.html")).xpath('//div[@id="zonePlayer"]/@data-src').first.value[2..-1]

# puts affiche un message dans la console
puts "Opening first part URL : #{first}"
# %x() permet d'executer une commande Linux, dans notre cas firefox
%x(firefox #{first})
puts "Opening second part URL : #{second}"
%x(firefox #{second})

# on supprime les fichiers créés avec la commande rm parce qu'on est pas des gros dégeu
%x(rm quotidien-first.html)
%x(rm quotidien-second.html)
