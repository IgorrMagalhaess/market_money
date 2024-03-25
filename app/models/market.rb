class Market < ApplicationRecord
   has_many :market_vendors
   has_many :vendors, through: :market_vendors

   def calculate_vendor_count
      vendors.count
   end
end