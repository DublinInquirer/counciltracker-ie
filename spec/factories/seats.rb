FactoryBot.define do
  factory :seat do
    council_session
    local_electoral_area
    councillor
    party
  end
end