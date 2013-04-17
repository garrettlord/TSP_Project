class Poll < ActiveRecord::Base
  attr_accessible :group_id, :question, :name

  belongs_to :group
end
