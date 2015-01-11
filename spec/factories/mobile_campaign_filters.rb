# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mobile_campaign_filter do
    category "MyString"
    filter "MyString"
    is_active 1
    qual_input "MyString"
  end
end
