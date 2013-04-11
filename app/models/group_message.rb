class GroupMessage < ActiveRecord::Base
  attr_accessible :group_id, :message, :user_id

  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 160 }
end
