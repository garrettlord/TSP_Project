# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  phone_number    :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :password, :password_confirmation
  has_secure_password

  #groups
  has_many :group_users
  has_many :user_groups, through: :group_users, foreign_key: :user_id, class_name: "Group", source: :group

  has_many :group_admins
  has_many :admin_groups, through: :group_admins, foreign_key: :user_id, class_name: "Group", source: :group
  # has_many :groups, :through => :group_users

  # scramble
  has_one :scramble_game

  validates :name, presence: true, uniqueness: { case_sensitive: false },
      length: { maximum: 50 }

  VALID_PHONE_REGEX = /\A[0-9]{3}\-[0-9]{3}\-[0-9]{4}\z/i
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def all_groups
    self.user_groups + self.admin_groups
  end
end