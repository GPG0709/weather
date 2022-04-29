# DON'T CHANGE THIS CODE
# ----------------------
inicio = false
while inicio == false
    puts "The weather from which city do you want?"
    city = gets.chomp
    city = city.gsub(" ", "")
    require "net/http"
    require "json"
    url = "https://weatherdbi.herokuapp.com/data/weather/#{city}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    weather_data = JSON.parse(response)

    if weather_data["status"] != "fail"
    inicio = true
    elsif weather_data["status"] == "fail"
        puts "Try again. The city could not be found"
    end
end
# ----------------------

# EXERCISE
# Using the Ruby hash `weather_data` that includes weather forecast data for Chicago,
# write a weather summary out to the screen including the current conditions and upcoming forecast.
# Something like the output below.

# Sample output:
# In Chicago, IL it is currently 67 degrees and cloudy.
# The rest of today will be a high of 65 and scattered shows.
# The upcomming weather forecast is:
# Wednesday: a high of 65 and scattered showers.
# Thursday: a high of 67 and partly cloudy.
# Friday: a high of 59 and rain.
# Saturday: a high of 77 and cloudy.
# ...

# STEPS
# Look at the weather_data hash.
# Find the current data.
# Build a string with the text and dynamic data from the hash.
# "In #{...} it is currently #{...} degrees and #{...}"
# Find the array of forecast data.
# Read only the first element of that array to display the conditions for the rest of today.
# Use a loop to display the daily summary for the upcoming forecast.

# 1. inspect the weather_data hash
puts weather_data
city = weather_data["region"]

current_temp = weather_data["currentConditions"]["temp"]["c"]
current_condition = weather_data["currentConditions"]["comment"]
puts "In #{city}, it is currently #{current_temp}C and #{current_condition}."

today_forecast = weather_data["next_days"][0]
puts "The rest of today will be a high of #{today_forecast["max_temp"]["c"]}C and #{today_forecast["comment"]}."

for daily_forecast in weather_data["next_days"]
    weekday = daily_forecast["day"]
    high_temp = daily_forecast["max_temp"]["c"]
    low_temp = daily_forecast["min_temp"]["c"]
    condition = daily_forecast["comment"]
    puts "#{weekday}: a minimum of #{low_temp}C, a maximum of #{high_temp}C, and #{condition}."
end

# current = [ ]
# forecasts = [ ]


# # i = 0
# # while i <= weather_data["next_days"].size
# #     forecasts[i]= [weather_data["next_days"][i]["day"],
# #     weather_data["next_days"][i]["max_temp"]["c"],
# #     weather_data["next_days"][i]["min_temp"]["c"],
# #     weather_data["next_days"][i]["comment"]]
    
#     i = i+1
# end

# puts forecasts[0]
# puts "In #{city} it is currently #{today[0]} degrees and #{today[1]}"
# puts "The following days will be:"
# puts forecasts[0]



# CHALLENGE
# Can you display the weather forecast summary for a user-entered city?
# Use the following code at the very top of the file and then replace "chicago" in the api url with the user-entered city:
# puts "What city are you in?"
# city = gets.chomp
# puts city
# Note: what happens if the user-entered value is not a known city? You'll want to do some error handling.

