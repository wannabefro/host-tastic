FactoryGirl.define do
  factory :ticket do
    name Faker::Name.name
    email Faker::Internet.email
    association :department
    body Faker::Lorem.paragraph
    subject Faker::Lorem.sentence
    association :assigned_staff, factory: :user
  end

end
