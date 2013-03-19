class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :users, :through => :group_users

  validates :name, presence: true, uniqueness: true,
      length: { maximum: 50 }
end
