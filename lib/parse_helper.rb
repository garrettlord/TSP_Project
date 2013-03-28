module ParseHelper
	
	def parse(message)
		input = message.split(" ")

		#Zero parameter functions

		case
		when input.at(0) == "food" or input.at(0) == "f"
			food

		#One parameter functions

		when input.at(0) == "?" or input.at(0) == "help" or input.at(0) == "h"
			help(input.at(1))
		when input.at(0) == "joingroup" or input.at(0) == "jg"
			joinGroup(input.at(1))
		when input.at(0) == "game" or input.at(0) == "g"
			game(input.at(1))
		when input.at(0) == "leavegroup" or input.at(0) == "lg"
			leaveGroup(input.at(1))
		when input.at(0) == "newgroup" or input.at(0) == "ng"
			newGroup(input.at(1))
		when input.at(0) == "newperson" or input.at(0) == "np"
			newPerson(input.at(1))
		when input.at(0) == "timer" or input.at(0) == "t"
			timer(input.at(1))
		when input.at(0) == "highscore" or input.at(0) == "hs"
			highscore(input.at(1))

		#Two parameter functions

		when input.at(0) == "addperson" or input.at(0) == "ap"
			addPerson(input.at(1), input.at(2))
		when input.at(0) == "alarm" or input.at(0) == "a"
			alarm(input.at(1), input)
		when input.at(0) == "messagegroup" or input.at(0) == "mg"
			messageGroup(input.at(1), input)
		when input.at(0) == "messageperson" or input.at(0) == "mp"
			messagePerson(input.at(1),input)
		when input.at(0) == "service" or input.at(0) == "s"
			service(input.at(1),input)
		when input.at(0) == "removeperson" or input.at(0) == "rp"
			removePerson(input.at(1),input.at(2))
		when input.at(0) == "weather" or input.at(0) == "w"
			weather(input.at(1),input.at(1))

		#Three parameter functions

		else
			errorMessage()
	end
end