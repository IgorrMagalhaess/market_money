FactoryBot.define do
   factory :market do
      name { Faker::Name.name }
      street { Faker::Address.street_address }
      city { Faker::Address.city }
      county { "Cobb" }
      state { Faker::Address.state }
      zip { Faker::Address.zip_code }
      lat { Faker::Address.latitude }
      lon { Faker::Address.longitude }
   end
end