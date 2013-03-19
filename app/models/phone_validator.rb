# split by comma, remove leading and trailing whitespace, and remove empty strings
def get_items_from_csv(value)
  value.split(",").collect{|n| n.strip}.select{|x| !x.empty?}
end

# custom validator for comma separated phone numbers
class PhoneValidator < ActiveModel::EachValidator

  PHONE_REGEX = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/

  def validate_each(record, attribute, value)

    # check for nil
    if !value
      record.errors[attribute] << "must contain a phone number"
      return;
    end

    # check for empty array
    numbers = get_items_from_csv(value)
    record.errors[attribute] << "must contain a phone number"  if numbers.count == 0

    numbers.each do |n|

      # ensure that n matches the PHONE_REGEX, and has no pre or post values
      m = PHONE_REGEX.match(n)
      unless m && m.pre_match.empty? && m.post_match.empty?
        record.errors[attribute] << "contains an invalid phone number: #{n}"
      end
    end
  end
end