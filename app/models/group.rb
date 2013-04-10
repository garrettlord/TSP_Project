# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :group_users
  has_many :users, through: :group_users, foreign_key: :group_id, class_name: "User", source: :user
  has_many :group_admins
  has_many :admins, through: :group_admins, foreign_key: :group_id, class_name: "User", source: :user
  # has_many :users, :through => :group_users

  validates :name, presence: true, uniqueness: true,
      length: { maximum: 50 }

  def group_all
    self.group_users + self.group_admins
  end
end