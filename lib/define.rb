module Define
	
	def get_definition(word)
		Wordnik.configure do |config|
		  config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'               # required
		end

		begin
			definition = Wordnik.word.get_definitions(word, :source_dictionaries => 'webster')
			
			definition = definition[0]["text"] #first definition found from Webster

			message = ""

			message << "Definition: #{definition}" 
			message << "\n"

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def

	def get_example(word)
		Wordnik.configure do |config|
		  config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'               # required
		end
		begin
			example = Wordnik.word.get_examples(word)
			
			example = example["examples"][0]["text"] #first definition found from Webster

			message = ""

			message << "Word Example: #{example}" 
			message << "\n"

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def

	def get_related(word)
		Wordnik.configure do |config|
		  config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'               # required
		end
		begin
			related = Wordnik.word.get_related(word)
			
			message = ""

			message << "Related Words: #{related[0]["words"].join(', ')}" 
			message << "\n"

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def

	def get_random(min, max)

		begin
			random = Wordnik.word.get_random_word(:part_of_speech => 'verb', :part_of_speech => 'noun', :part_of_speech => 'adjective', :minLength => min, :maxLength => max)

			message = ""

			message << "#{random["word"]}" 

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def

	def get_wotd()

		begin 
			wotd = Wordnik.words.get_word_of_the_day()
			
			message = ""

			message << "Word of the Day: #{ wotd["word"]}- #{wotd["definitions"][0]["text"]}" 

			rescue Exception => e
			message = "#{e.to_s}"

		end
	
		return message
	end

end #module
# Sample Output
	# Weather for Beverly Hills, CA
	# 60F - Mostly Cloudy
	# Wind 8mph at 250. Feels like 60F
	# Tomorrow's Forecast
	# AM Clouds/PM Sun. High: 66 Low: 52
