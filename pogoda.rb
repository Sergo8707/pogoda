require_relative 'lib/weather.rb'
require 'cyrillizer'

Cyrillizer.alphabet = "data/russian.yml"

puts "В каком городе хотите узнать погоду?"

weather = Weather.new(STDIN.gets.encode("UTF-8").to_lat.chomp)

weather.weather_in_the_city
