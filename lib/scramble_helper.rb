require File.join(Rails.root, "/app/models/scramble_game.rb")
require File.join(Rails.root, "lib/define.rb")

module ScrambleHelper
	include Define


	#method that is called by parse_helper
	def playGame(user, message)
		#Set up the game if this is the user's first time
		if user.scramble_game == nil
			game = ScrambleGame.create user_id: user.id
			# game.user_id = user.id
			# game.save
			return initScrambleGame(game)
		end

		#passes on the word to the game
		game = user.scramble_game
		play(game, message)
	end

#Start ScrambleGame logic

	#Main method for a game
	def play(game, message)
		round = game.scramble_round
		score = game.score

		if status(round) >= 2 
			return initRound(round)
		end

		if message[0, 6] == "-start"
			return initRound(round)
		end

		out = checkWord(round, message)

		#out << word.to_s[0,5]

		if status(round) == 3
			game.score = score.to_i + round.roundScore.to_i
		end

		if status(round) >= 2
			out << " Your total score is: #{score}. "
		end
		return out
	end #end play

	#Sets up a game, run only if a user doesn't have a game
	def initScrambleGame(game)
		game.update_attributes score: 0
		round = ScrambleRound.new
		round.scramble_game_id = game.id
		round.save
		initRound(round)
	end


#Start ScrambleRound logic


	#Sets up a round. Called each time a new round is made
	def initRound(round)
		round.roundScore = 10
		round.usedHint = 0
		round.correctWord = get_random(5, 7)
		#round.correctWord = "tacoleg"
		round.correctWord = round.correctWord.to_s
		round.scrambledWord = randomizeString(round.correctWord).to_s

		return "Starting new round... Scrambled word is: #{round.scrambledWord}"
	end

	#Checks if a word is correct. Handles parsing for "-hint"
	
	def checkWord(round, inWord)
	
		#Logic to deal with word
		if inWord[0, 5] == "-hint"

			if round.usedHint ==  0
				round.roundScore += -4
				round.usedHint = 1
				return hint(inWord)
			else
				return "You have already used your hint for this round"
			end
		else

		  # if the word is correct, return score 
			if inWord == round.correctWord
				round.usedHint = 3
				return "#{inWord} is correct! Score for this round is: #{round.roundScore}."
			else
			#If the word is incorrect
				round.roundScore += -2

				if round.roundScore <= 0
					round.usedHint = 2
					return "Round over! You used all your attempts. The correct word was #{round.correctWord}. "
				end
				return "#{inWord} is incorrect! Please try again. The word is: #{round.scrambledWord}. "
			end
		end#end word logic

			round.roundScore
	end #end checkWord

	#Returns the definition of a word. Can only be used once per round
	def hint(word)
		return get_definition(word) 
	end

	#Scrambles a word
	def randomizeString(word)
		word.split("").shuffle.join
	end

	#Returns the status of the given round. 
	def status(round)
		round.usedHint
	end

	def debug(user)
		puts user
		game = user.scramble_game
		#round = game.scramble_round
		out = ""
		out << game
		#out << "Correct word is: #{round.correctWord}\n"
		# out << "Scrambled word is: #{round.scrambledWord}\n"
		# out << "Round score is: #{round.roundScore}\n"
		# out << "Round status is: #{round.usedHint}\n"
		# out << "Game score is: #{game.score}"
		out
	end


end