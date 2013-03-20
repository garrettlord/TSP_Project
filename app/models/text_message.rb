# NOTE this model is not an ActiveRecord
class TextMessage
  include ActiveModel::Conversion
  include ActiveModel::Validations

  # attributes hash is read for validation
  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  # custom accessors
  def message
    @attributes[:message]
  end

  def group_name
    @attributes[:group_name]
  end

  # validation
  validates :message, :presence => true
  validates_length_of :message, :maximum => 160

  # parses :numbers into an array of unique, 10 digit numbers (only for valid records)
  def numbers_array
    numbers = []
    Group.find_by_name(group_name).users.each do |user|
      numbers << user.phone_number
    end
    return numbers
  end

  # needed for form not to try to access db
  def persisted?
    false
  end

end
