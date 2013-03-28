module Weather
	def get_weather(zip)
		appid = 'LCQO6F3V34FE6FIki6XMq3Pg8pd46EgovEi7AYFFTcA4cStxIre2CB8tpE7Xy.PjfL_OUgrk_MJ64JG.bLDXkx_XazODfr4-'
		@client = YahooWeather::Client.new(appid)
		country = 'US'

		zip = GoingPostal.postcode? zip, country

		begin

		response = @client.lookup_zip(zip)

		message = ""

		@ForC = response.units.temperature
		loc = response.title
		index = loc.rindex(',')
		index = index + 3
		space = loc.index(' ') + 1

		loc = loc[space..index]
		message << "Weather #{loc}"
		message << "\n"
		message << "#{response.condition.temp}#{ForC} - #{response.condition.text}"
		message << "\n"

		dir = Geocoder::Calculations.compass_point(response.wind.direction)

		message << "Wind #{dir} #{response.wind.speed}#{response.units.speed}. Feels like #{response.wind.chill}#{ForC}"
		message << "\n"
		message << "Tomorrow's Forecast"
		message << "\n"
		message << "#{response.forecasts[1].text}.  High: #{response.forecasts[1].high} Low: #{response.forecasts[1].low}"
		message << "\n"

		rescue
		 	message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def
end #module
# Sample Output
	# Weather for Beverly Hills, CA
	# 60F - Mostly Cloudy
	# Wind 8mph at 250. Feels like 60F
	# Tomorrow's Forecast
	# AM Clouds/PM Sun. High: 66 Low: 52