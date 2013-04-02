class ScrambleRound < ActiveRecord::Base
  attr_accessible :correctWord, :roundScore, :scramble_game_id, :scrambledWord, :usedHint, :finishedRound

  belongs_to :scramble_game

  def initRound
  	@roundScore = 10
  	@usedHint = 0
  	@finishedRound = 0
  	#Generate random word from Garret's code

  	return "Starting new round... Scrambled word is: #{scrambledWord}"

  end

  def checkWord(word)
  	if finishedRound == 1
  		initRound
  	end

  	if word[0, 1] == "h "
  		if @usedHint == 0
  			hint(word)
  			@roundScore += -4
  			return @usedHint = 1
  		else
  			return "You have already used your hint for this round"
  		end
  		return hint(word)
  	else
  		if word == correctWord
  			@finishedRound = 1
  			return "Correct! Score for this round is: #{@roundScore}."
  		else
  			@roundScore += -2
  			if @roundScore <= 0
  				@finishedRound = 1
  				return "Round over! You used all your attempts"
  			end
  			return "Incorrect! Please try again."
  		end
  	end
  	@roundScore
  end

  def hint(word)
  	#Call to Garret's thing, get definition
  end

  def randomizeString(word)
  	word.split("").shuffle.join
  end

  def isOver
  	@finishedRound
  end
end
