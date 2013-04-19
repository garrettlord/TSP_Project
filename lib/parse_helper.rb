require File.join(Rails.root, "lib/twilio_helper.rb")
require File.join(Rails.root, "lib/weather.rb")
require File.join(Rails.root, "lib/define.rb")
require File.join(Rails.root, "lib/movie.rb")
require File.join(Rails.root, "lib/food.rb")
require File.join(Rails.root, "/lib/scramble_helper.rb")

module ParseHelper
	include TwilioHelper
	include Weather
	include Define
  include Movie
  include Food
	include ScrambleHelper

	def parse(user, message)
    puts "parsing"
		input = message.split(" ")
		output = ""

		#Zero parameter functions

		case input[0].downcase
			when "weather", "w"
				output = weather(input[1])  # zipcode
			when "word-define", "wd"
				output = definition(input[1]) # word
			when "word-example", "we"
				output = example(input[1])  # word
			when "word-related", "wr"
				output = related(input[1])  # word
			when "scramble", "scr"
				output = scramble(user, input[1])
			when "wotd", "word-of-the-day"
      	  output = wotd()
         when "food", "f"
      	  output = food(input[1], input[2])
			when "messagegroup", "mg"
            group = Group.find_by_name(input[1])
				messageGroup(user, group, input[2..-1].join(" ")) # message
         when "poll", "p"
            output = "Thank you for your response"
            poll(user, input[1], input[2])  # poll id, response
			else
				output = "Could not process request"
		end

		# send the message
    send_text(user.phone_number, output)
	end
	
	def messageGroup(from, group, message)
		# send the message
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

  def wotd()
  	return get_wotd()
  end 

  def food(meal, day)
  	return get_food(meal, day)
  end

  def poll(user, pollid, response)
    resp = PollResponse.create(user_id: user.id, poll_id: pollid, response: response)
  end

  def scramble(user, word)
  	return playGame(user, word)
  end
end
