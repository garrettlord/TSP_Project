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

  def numbers
    @attributes[:numbers]
  end

  # validation
  validates :numbers, :phone => true
  validates :message, :presence => true
  validates_length_of :message, :maximum => 160

  # parses :numbers into an array of unique, 10 digit numbers (only for valid records)
  def numbers_array
    get_items_from_csv(numbers).collect{|x| x.gsub(/\D/, "")}.uniq
  end

  # needed for form not to try to access db
  def persisted?
    false
  end

end
