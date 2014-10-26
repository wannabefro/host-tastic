FactoryGirl.define do
  factory :ticket do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    association :department
    body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.sentence }

    trait :waiting_for_staff_response do
      status 'waiting_for_staff_response'
    end

    trait :waiting_for_customer do
      status 'waiting_for_customer'
    end

    trait :on_hold do
      status 'on_hold'
    end

    trait :cancelled do
      status 'cancelled'
    end

    trait :completed do
      status 'completed'
    end

    trait :assigned_staff do
      association :assigned_staff, factory: :user
    end
  end
end
