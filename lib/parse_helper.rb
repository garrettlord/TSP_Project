require File.join(Rails.root, "lib/twilio_helper.rb")
require File.join(Rails.root, "lib/weather.rb")
require File.join(Rails.root, "lib/define.rb")
require File.join(Rails.root, "lib/movie.rb")

module ParseHelper
	include TwilioHelper
	include Weather
	include Define
  include Movie

	def parse(user, message)
    puts "parsing"
		input = message.split(" ")
		output = ""

		#Zero parameter functions

		case input[0].downcase
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
			when "word-define", "wd"
				output = definition(input[1])
			when "word-example", "we"
				output = example(input[1])
			when "word-related", "wr"
				output = related(input[1])
      when "movie", "m"
        output = movie(input[1..-1].join(" "))

			#Two parameter functions

			# when input.at(0) == "addperson" or input.at(0) == "ap"
			# 	addPerson(input.at(1), input.at(2))
			# when input.at(0) == "alarm" or input.at(0) == "a"
			# 	alarm(input.at(1), input)
			when "messagegroup", "mg"
        group = Group.find_by_name(input[1])
				messageGroup(user, group, input[2..-1].join(" "))
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
				output = "Could not process request"
		end

		# send the message
    puts "output: #{output}"
    texts = output.scan(/.{1,120}/m)

    texts.each do |text|
      send_text(user.phone_number, text)
      puts "#{user.phone_number}: #{text}"
    end
	end

	def messageGroup(from, group, message)
		# send the message
    	message = "#{group.name}: #{from.name} - #{message}"
    	send_group_text(from, group, message)
	end

 	def weather(zip)
		return get_weather(zip)
	end

	def definition(word)
		return get_definition(word)	
	end

	def example(word)
		return get_example(word)
	end

	def related(word)
		return get_related(word)
	end

  def movie(movie)
    return find_movie(movie)
  end
end
