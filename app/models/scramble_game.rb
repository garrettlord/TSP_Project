class ScrambleGame < ActiveRecord::Base
  attr_accessible :score, :user_id

  belongs_to :user
  has_one :scramble_round

  def initScrambleGame(user_id)
  	@user = User.find(user_id)
  	@score = 0
  	@scramble_round = Round.new
  end

  def startRound(word)
  	out = @sramble_round.checkWord(word)
  	if @scramble_round.isOver
  		out << " Your total score is: #{@score}"
  	end
  	return out
  end
end
