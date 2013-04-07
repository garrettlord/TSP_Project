class ScrambleGame < ActiveRecord::Base
  attr_accessible :score, :user_id

  belongs_to :user
  has_one :scramble_round

  #sets ups the game if the user doesnt have a game yet
  def initScrambleGame()
  	@score = 0
  	@round = scramble_round.new
    @round.initRound()
  end

  # Calls stuff from round
  def play(word)
  	out = @round.checkWord(word)
  	if @round.status() == 2
  		out << " Your total score is: #{@score}"
  	end
  	return out
  end
end
