require File.join(Rails.root, "lib/twilio_helper.rb")
require File.join(Rails.root, "lib/weather.rb")

module ParseHelper
	include TwilioHelper
	include Weather

	def parse(user, message)
		input = message.downcase.split(" ")
		output = ""

		#Zero parameter functions

		case input[0]
			# when input.at(0) == "food" or input.at(0) == "f"
			# 	food

			#One parameter functions

			# when input.at(0) == "?" or input.at(0) == "help" or input.at(0) == "h"
			# 	help(input.at(1))
			# when input.at(0) == "joingroup" or input.at(0) == "jg"
			# 	joinGroup(input.at(1))
			# when input.at(0) == "game" or input.at(0) == "g"
			# 	game(input.at(1))
			# when input.at(0) == "leavegroup" or input.at(0) == "lg"
			# 	leaveGroup(input.at(1))
			# when input.at(0) == "newgroup" or input.at(0) == "ng"
			# 	newGroup(input.at(1))
			# when input.at(0) == "newperson" or input.at(0) == "np"
			# 	newPerson(input.at(1))
			# when input.at(0) == "timer" or input.at(0) == "t"
			# 	timer(input.at(1))
			# when input.at(0) == "highscore" or input.at(0) == "hs"
			# 	highscore(input.at(1))
			when "weather", "w"
				output = weather(input[1])

			#Two parameter functions

			# when input.at(0) == "addperson" or input.at(0) == "ap"
			# 	addPerson(input.at(1), input.at(2))
			# when input.at(0) == "alarm" or input.at(0) == "a"
			# 	alarm(input.at(1), input)
			when "messagegroup", "mg"
				messageGroup(user.name, input[1], input[2..-1].join(" "))
			# when input.at(0) == "messageperson" or input.at(0) == "mp"
			# 	messagePerson(input.at(1),input)
			# when input.at(0) == "service" or input.at(0) == "s"
			# 	service(input.at(1),input)
			# when input.at(0) == "removeperson" or input.at(0) == "rp"
			# 	removePerson(input.at(1),input.at(2))
			# when input.at(0) == "weather" or input.at(0) == "w"
			# 	weather(input.at(1),input.at(1))

			#Three parameter functions

			else
				# errorMessage()
		end

		# send the message
		send_text(user.phone_number, output)
	end

	def messageGroup(from, group, message)
		# send the message
    	message = "#{group}: #{from} - #{message}"
    	send_group_text(group, message)
	end

 	def weather(zip)
		return get_weather(zip)
	end
end
