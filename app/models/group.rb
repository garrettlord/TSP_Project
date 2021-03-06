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
  attr_accessible :name, :public

  # user types
  has_many :group_users
  has_many :users,
      through: :group_users,
      foreign_key: :group_id,
      class_name: "User", source: :user,
      conditions: {"group_users.admin" => false}
  has_many :admins,
      through: :group_users,
      foreign_key: :group_id,
      class_name: "User", source: :user,
      conditions: {"group_users.admin" => true}
  has_many :members,
      through: :group_users,
      foreign_key: :group_id,
      class_name: "User", source: :user

  has_many :polls

  validates :name, presence: true, uniqueness: true,
      length: { maximum: 50 }

end
