class ScrambleGame < ActiveRecord::Base
  attr_accessible :score, :user_id

  belongs_to :user
  has_one :scramble_round

  def initScrambleGame(user_id)
  	@user = user.find(user_id)
  	@score = 0
  	@round = scramble_round.new
  end

  def play(word)
  	out = @round.checkWord(word)
  	if @round.status() == 2
  		out << " Your total score is: #{@score}"
  	end
  	return out
  end
end
