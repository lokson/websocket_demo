FactoryGirl.define do
  factory :user do
    sequence :name, ['Lord Vader', 'Luke Skywalker', 'Master Joda', 'Anakin Skywalker', 'Princess Leya'].cycle
  end
end