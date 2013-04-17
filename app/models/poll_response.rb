class PollResponse < ActiveRecord::Base
  attr_accessible :poll_id, :response, :user_id

  belongs_to :poll
  belongs_to :user

  validates :poll_id, presence: true
  validates :user_id, presence: true
  validates :response, presence: true
end
