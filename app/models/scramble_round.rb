class ScrambleRound < ActiveRecord::Base
  attr_accessible :correctWord, :roundScore, :scramble_game_id, :scrambledWord, :usedHint

  belongs_to :scramble_game
end
