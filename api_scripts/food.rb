require 'rubygems'
require 'open-uri'
require 'rss'

module Food
 def get_food(meal, day)
		begin
		url = "http://www.aux.mtu.edu/dining_local/rss/"
		rss = open(url)
		feed = RSS::Parser.parse(rss)
		menu = feed.channel.items[1]

		if(day != nil)
			day = day.upcase
		end # if

		case day
			when nil, "TODAY"
				menu = feed.channel.items[1]
			when "TOMORROW", "TOM"
				menu = feed.channel.items[2]
		end # case
	
		message = ""
		date = menu.title[19..-1]
		food = menu.description # food is a string!

		chs = "<p>", "<h4>", "</h4>", "</p>"
		for ch in chs
			while food.index(ch) != nil do
				food[ch] = ""
			end # while
		end # for

		ch = "<br />"
		while food.index(ch) != nil do
			food[ch] = " "
		end # while

		bindex = food.index("Breakfast") + 9
		lindex = food.index("Lunch") + 5
		dindex = food.index("Dinner") + 6

		breakfast = food[bindex..lindex - 6]
		lunch = food[lindex..dindex - 7]
		dinner = food[dindex..food.length - 7]

		case meal.upcase
			when "BREAKFAST", "B"
				message << "Breakfast"
				message << date
				message << breakfast
			when "LUNCH", "L"
				message << "Lunch"
				message << date
				message << lunch
			when "DINNER", "D"
				message << "Dinner"
				message << date
				message << dinner

			else 
				fail
		end # case

		rescue
			message = "Error: Something went wrong."

		end # begin

		return message
	end # def
		
end # module