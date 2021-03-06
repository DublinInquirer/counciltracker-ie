FactoryBot.define do
  factory :co_option do
    association :outgoing_seat, factory: :seat
    association :incoming_councillor, factory: :councillor
    association :incoming_party, factory: :party
    occurred_on { Faker::Date.backward(365) }
  end
end
