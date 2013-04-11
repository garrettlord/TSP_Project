# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_message do
    user_id 1
    group_id ""
    message "MyString"
  end
end
