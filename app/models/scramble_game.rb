class ScrambleGame < ActiveRecord::Base
  attr_accessible :score, :user_id

  belongs_to :user
  has_one :scramble_round
end
