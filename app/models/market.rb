class Market < ApplicationRecord
   has_many :market_vendors
   has_many :vendors, through: :market_vendors

   def vendor_count
      vendors.count
   end

   def self.find_by_state_name_and_city(state, city, name)
      Market.where("state ILIKE ? AND city ILIKE ? AND name ILIKE ?",
         "%#{state}%", "%#{city}%", "%#{name}%")
   end

   def self.find_by_state_and_city(state, city)
      Market.where("state ILIKE ? AND city ILIKE ?",
         "%#{state}%", "%#{city}%")
   end

   def self.find_by_state_and_name(state, name)
      Market.where("state ILIKE ? AND name ILIKE ?",
         "%#{state}%", "%#{name}%")
   end

   def self.find_by_name(name)
      Market.where("name ILIKE ?", "%#{name}%")
   end

   def self.find_by_state(state)
      Market.where("state ILIKE ?", "%#{state}%")
   end

end