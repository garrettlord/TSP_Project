require File.join(Rails.root, "lib/define.rb")

class ScrambleRound < ActiveRecord::Base
  include Define
  # correctWord: Stores the correct word
  # roundScore: Keeps track of the number of chances and hints a user has. Starts at 10
  # scramble_game_id: id number for which game this belongs to
  # scrambledWord: The scrambled version of correctWord
  # usedHint: keeps status about the game. 0 = hint unused. 1 = hint used. 2 = round over. Should probably rename to statust
  attr_accessible :correctWord, :roundScore, :scramble_game_id, :scrambledWord, :usedHint
  belongs_to :scramble_game

  def initRound
  	@roundScore = 10
  	@usedHint = 0
  	@correctWord = random = Wordnik.words.get_random_word(:part_of_speech => 'verb', :part_of_speech => 'noun', :part_of_speech => 'adjective', :minLength => '4', :maxLength => '7')
    @scrambledWord = randomizeString(@correctWord)

  	return "Starting new round... Scrambled word is: #{@scrambledWord}"

  end

  def checkWord(word)
    #Checks if round has been started
  	if usedHint == 2
  		return initRound
  	end #round start check

    #Logic to deal with word
  	if word[0, 4] == "-hint"
  		if @usedHint == 0
  			@roundScore += -4
        @usedHint = 1
  			return hint(word)
  		else
  			return "You have already used your hint for this round"
  		end
  		return hint(word)
  	else
      # if the word is correct, return score 
  		if word == correctWord
  			@usedHint = 2
  			return "Correct! Score for this round is: #{@roundScore}."
  		else
        #If the word is incorrect
  			@roundScore += -2
  			if @roundScore <= 0
  				@usedHint = 2
  				return "Round over! You used all your attempts. The correct word was #{@correctWord}"
  			end
  			return "Incorrect! Please try again. The word is: #{@scrambledWord}"
  		end
  	end#end word logic
  	@roundScore
  end #end checkWord

  def hint(word)
  	return Wordnik.word.get_definitions(word, :limit=>2, :source_dictionaries => 'webster')
  end

  def randomizeString(word)
  	word.split("").shuffle.join
  end

  def status
  	@usedHint
  end
end
