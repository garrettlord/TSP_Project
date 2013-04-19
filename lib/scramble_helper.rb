require File.join(Rails.root, "/app/models/scramble_game.rb")
require File.join(Rails.root, "lib/define.rb")

module ScrambleHelper
	include Define
	@wordList 

	#method that is called by parse_helper
	def playGame(user, message)
		#Set up the game if this is the user's first time
		if user.scramble_game == nil
			game = user.create_scramble_game 
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
			out << " Your total score is: #{game.score}. "
		end
		return out
	end #end play

	#Sets up a game, run only if a user doesn't have a game
	def initScrambleGame(game)
		initWords()
		game.update_attributes score: 0
		game.create_scramble_round
		round = game.scramble_round
		initRound(round)
		initRound(round)
	end


#Start ScrambleRound logic


	#Sets up a round. Called each time a new round is made
	def initRound(round)
		rand = Random.new()
		i = rand(1..50)
		round.roundScore = 10
		round.usedHint = 0
		round.correctWord = @wordList[i]
		#round.correctWord = get_random(4, 8)
		#round.correctWord = "apple"
		round.correctWord = round.correctWord.to_s
		round.scrambledWord = randomizeString(round.correctWord).to_s

		round.save

		return "Starting new round... Scrambled word is: #{round.scrambledWord}"
	end

	#Checks if a word is correct. Handles parsing for "-hint"
	
	def checkWord(round, inWord)
	
		#Logic to deal with word
		if inWord[0, 5] == "-hint"

			if round.usedHint ==  0
				if round.roundScore <=4
					return "You have used too many guesses to use your hint!"
				end
				round.roundScore += -4
				round.usedHint = 1
				return hint(round.correctWord)
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
		get_definition(word) 
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
		round = game.scramble_round
		out = ""
		# out << game
		out << "Correct word is: #{round.correctWord}\n"
		out << "Scrambled word is: #{round.scrambledWord}\n"
		out << "Round score is: #{round.roundScore}\n"
		out << "Round status is: #{round.usedHint}\n"
		out << "Game score is: #{game.score}"
		out
	end

	def initWords()
		if(@wordList == true)
			return
		end

		@wordList = { 	 1 => "stupid",
						 2 => "toenail",
						 3 => "potato",
						 4 => "crafter",
						 5 => "princess",
						 6 => "apple",
						 7 => "tabletop",
						 8 => "dragon",
						 9 => "pipes",
						10 => "ninja",
						11 => "experience",
						12 => "doctor",
						13 => "friends",
						14 => "computer",
						15 => "syndrome",
						16 => "monster",
						17 => "swords",
						18 => "waterfall",
						19 => "fireball",
						20 => "willow",
						21 => "magic",
						22 => "herbivore",
						23 => "carnivore",
						24 => "northern",
						25 => "cloaks",
						26 => "camera",
						27 => "wizard",
						28 => "football",
						29 => "soccer",
						30 => "adventure",
						31 => "defeated",
						32 => "second",
						33 => "wallop",
						34 => "classes",
						35 => "screaming",
						36 => "rubber",
						37 => "creature",
						38 => "national",
						39 => "flying",
						40 => "energy",
						41 => "science",
						42 => "mechanical",
						43 => "wolf",
						44 => "electrical",
						45 => "skipping",
						46 => "frolic",
						47 => "herbal",
						48 => "reddit",
						49 => "internet",
						50 => "awesome"
					}
	end
end