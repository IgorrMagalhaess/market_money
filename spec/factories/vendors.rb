FactoryBot.define do
  factory :vendor do
    name { Faker::Company.name }
    description { Faker::Commerce.department }
    contact_name { Faker::Esport.player }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { Faker::Boolean.boolean }
  end
end
