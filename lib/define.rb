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
	
		%w(rubygems wordnik).each {|lib| require lib}

		Wordnik.configure do |config|
    		config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'
		end

		begin
			example = Wordnik.word.get_examples(word)
			
			example = example["examples"][0]["text"] #first definition found from Webster

			message = ""

			message << "Definition: #{example}" 
			message << "\n"

		rescue Exception => e
			message = "#{e.to_s}"
		 	# message = "ERROR 69:\nSomething went wrong."

		end #begin

		return message
	end #def

	def get_related(word)
	
		%w(rubygems wordnik).each {|lib| require lib}

		Wordnik.configure do |config|
    		config.api_key = 'd41d2d7c76970666c300a0a3cfa019bd4fd633ddc240fadb0'
		end

		begin
			related = Wordnik.word.get_examples(word)
			
			related = related[0]["words"] #first definition found from Webster

			message = ""

			message << "Definition: #{related}" 
			message << "\n"

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