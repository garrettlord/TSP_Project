class ScrambleGame < ActiveRecord::Base
  attr_accessible :score, :user_id

  belongs_to :user
  has_one :scramble_round

  #sets ups the game if the user doesnt have a game yet
  def initScrambleGame()
  	@score = 0
  	@round = ScrambleRound.new
    @round.initRound()
  end

  # Calls stuff from round
  def play(word)
    if(@round.status >=2 )
      @round = ScrambleRound.new
      return @round.initRound()
    end

  	out = @round.checkWord(word)

    #out << word.to_s[0,5]

    if @round.status == 3
      @score = @score.to_i + @round.roundScore.to_i
    end

  	if @round.status >= 2
  		out << " Your total score is: #{@score}. "
  	end
  	return out
  end

  def debug
    @round.debug
  end
end
