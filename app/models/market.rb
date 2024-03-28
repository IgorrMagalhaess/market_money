class Market < ApplicationRecord
   has_many :market_vendors
   has_many :vendors, through: :market_vendors

   # validates :credit_accepted, presence: true

   def vendor_count
      vendors.count
   end
end