FactoryGirl.define do
  factory :response do
    body Faker::Lorem.paragraph    
    association :ticket
    association :staff, factory: :user
  end

end
