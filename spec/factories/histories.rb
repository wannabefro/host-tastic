FactoryGirl.define do
  factory :history do
    association :ticket
    notes Faker::Lorem.sentence
  end

end
