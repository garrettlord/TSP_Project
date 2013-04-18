module Help
	def get_help(service)
		begin
			message = ""

			if(service != nil)
				service = service.downcase
			end # if

			case service
				when nil
					message << "Available Services:"
					message << "\n"
					message << "weather (w)"
					message << "\n"
					message << "movie (m)"
					message << "\n"
					message << "food (f)"
					message << "\n"
					message << "Word Definitions (wd)"
					message << "\n"
					message << "Related Words (wr)"
					message << "\n"
					message << "Word Examples (we)"
					message << "\n"
					message << "Group Messaging (mg)"
					message << "\n"
					message << "Help (h)"
					message << "\n"
					message << "Text help 'service key' for more info"

				when "help", "h", "?"
					message << "Format for Help: help 'service' OR h 'service' OR ? 'service'"
					message << "\n"
					message << "EX: help mg OR h mg OR ? mg"

				when "weather", "w"
					message << "Format for Weather: w 'ZIP code' OR weather 'ZIP code'"
					message << "\n"
					message << "EX: w 49931 OR weather 49931"

				when "word-define", "wd"
					message << "Format for Word Definitions: wd 'word' OR word-define 'word'"
					message << "\n"
					message << "EX: wd apple OR word-define apple"

				when "word-example", "we"
					message << "Format for Word Examples: we 'word' OR word-example 'word'"
					message << "\n"
					message << "EX: we apple OR word-example apple"

				when "word-related", "wr"
					message << "Format for Related Words: wr 'word' OR word-related 'word'"
					message << "\n"
					message << "EX: wr apple OR word-related apple"
		    
		    when "movie", "m"
		    	message << "Format for Movie: m 'Search terms' OR movie 'Search terms'"
					message << "\n"
					message << "EX: m Dark Knight OR movie Dark Knight"
		    
		    when "food", "f"
					message << "Format for Food: f 'meal' 'day' OR food 'meal' 'day'"
					message << "\n"
					message << "meal: b OR breakfast; l OR lunch; d OR dinner"
					message << "\n"
					message << "day: leave blank OR today; tom OR tomorrow"
					message << "\n"
					message << "EX: f l tom OR food lunch tomorrow"
					
				when "messagegroup", "mg"
					message << "Format for Group Messaging: mg 'team name' 'message' OR messagegroup 'team name' 'message'"
					message << "\n"
					message << "EX: mg teambuilding Hello World! OR messagegroup teambuilding Hello World!"
			end # case

		rescue
			message = "Error: Something went wrong."
		end # begin
		return message
	end # def	
end # module