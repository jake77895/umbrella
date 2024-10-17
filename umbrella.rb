require "http"
require "json"
require "dotenv/load"

pp "What is your location?"

location = gets.chomp

# Creating variable with pirate weather API key info
pirate_weather_api_key = ENV["PIRATE_WEATHER_KEY"]

# Creating variable with pirate weather API key info
google_maps_api_key = ENV["GMAPS_KEY"]

# Pulling the correct url for Google
google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=" + google_maps_api_key

gmap_raw_response = HTTP.get(google_maps_url)

gmap_parsed_response = JSON.parse(gmap_raw_response)

gmap_hash_1 = gmap_parsed_response.fetch("results").first

gmap_hash_2 = gmap_hash_1.fetch("geometry")

gmap_hash_3 = gmap_hash_2.fetch("location")

lat = gmap_hash_3.fetch("lat").to_s
long = gmap_hash_3.fetch("lng").to_s

# Pulling the correct url for the location
# UPDATE - Replace the latitude and logitude later
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + lat + "," + long

pp pirate_weather_url 

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
