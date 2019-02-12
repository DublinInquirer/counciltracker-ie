FactoryBot.define do
  factory :event do
    council_session
    association :eventable, factory: :change_of_affiliation
    occurred_on { Faker::Date.backward(30) }
  end
end