module Define
	
	def get_definition(word)

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

		begin
			related = Wordnik.word.get_examples(word)
			
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
			random = Wordnik.words.get_random_word(:part_of_speech => 'verb', :part_of_speech => 'noun', :part_of_speech => 'adjective', :minLength => min, :maxLength => max)

			message = ""

			message << "#{random["word"]}" 

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

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