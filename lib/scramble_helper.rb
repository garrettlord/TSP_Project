require File.join(Rails.root, "/app/models/scramble_game.rb")

module ScrambleHelper
	#method that calls stuff from ScrambleGame
	def playGame(user, message)
		#Set up the game if this is the user's first time
		if user.scramble_game == nil
			game = ScrambleGame.new
			user.scramble_game = game
			return game.initScrambleGame()
		end

		#passes on the word to the game
		user.scramble_game.play(message) 
	end

	def debug(user)
		game = user.scramble_game
		game.debug
	end
end