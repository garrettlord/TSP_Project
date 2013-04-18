require File.join(Rails.root, "lib/define.rb")

class ScrambleRound < ActiveRecord::Base
  include Define
  # correctWord: Stores the correct word
  # roundScore: Keeps track of the number of chances and hints a user has. Starts at 10
  # scramble_game_id: id number for which game this belongs to
  # scrambledWord: The scrambled version of correctWord
  # usedHint: keeps status about the game. 
  #    0 = hint unused. 
  #    1 = hint used. 
  #    2 = round lost. 
  #    3 = round won 
  #    Should probably rename to status
  # 

  attr_accessible :correctWord, :roundScore, :scramble_game_id, :scrambledWord, :usedHint
  belongs_to :scramble_game

  # def initRound
  # 	@roundScore = 10
  # 	@usedHint = 0
  # 	@correctWord = get_random(5, 7)
  #   #@correctWord = "apple"
  #   @scrambledWord = randomizeString(@correctWord).to_s
  #   @correctWord = @correctWord.to_s

  # 	return "Starting new round... Scrambled word is: #{@scrambledWord}"

  # end

  # def checkWord(word)
  #   #Checks if round has been started

  #   #Logic to deal with word
  # 	if word[0, 5] == "-hint"

  # 		if @usedHint ==  0
  # 			@roundScore += -4
  #       @usedHint = 1
  # 			return hint(word)
  # 		else
  # 			return "You have already used your hint for this round"
  # 		end
  # 	else

  #     # if the word is correct, return score 
  # 		if word == @correctWord
  # 			@usedHint = 3
  # 			return "#{word} is correct! Score for this round is: #{@roundScore}."
  # 		else
  #       #If the word is incorrect
  # 			@roundScore += -2

  # 			if @roundScore <= 0
  # 				@usedHint = 2
  # 				return "Round over! You used all your attempts. The correct word was #{@correctWord}. "
  # 			end
  # 			return "#{word} is incorrect! Please try again. The word is: #{@scrambledWord}. "
  # 		end
  # 	end#end word logic

  # 	@roundScore
  # end #end checkWord

  # def hint(word)
  #   return get_definition(word) 
  # end

  # def randomizeString(word)
  # 	word.split("").shuffle.join
  # end

  # def status
  # 	@usedHint
  # end

  # def debug
  #   out = ""
  #   out << "Correct word is: #{@correctWord}\n"
  #   out << "Scrambled word is: #{@scrambledWord}\n"
  #   out << "Round score is: #{@roundScore}\n"
  #   out << "Round status is: #{@usedHint}\n"
  #   out
  # end

  # def roundScore
  #   @roundScore
  # end
end
