# NOTE this model is not an ActiveRecord
class TextMessage
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :group_id, :message

  validates :group_id, presence: true
  validates :message, presence: true

  # attributes hash is read for validation
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # parses :numbers into an array of unique, 10 digit numbers (only for valid records)
  def numbers_array
    numbers = []
    Group.find(group_id).members.each do |user|
      numbers << user.phone_number
    end
    return numbers, group_id
  end

  # needed for form not to try to access db
  def persisted?
    false
  end

end
