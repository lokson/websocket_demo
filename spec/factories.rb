FactoryGirl.define do
  factory :user do
    sequence :name, ['Lord Vader', 'Luke Skywalker'].cycle
  end
end