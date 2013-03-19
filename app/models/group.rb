class Group < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true,
      length: { maximum: 50 }
end
