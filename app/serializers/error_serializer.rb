class ErrorSerializer
   def initialize(error_object)
      @error_object = error_object
   end

   def serialize_json
      {
         errors: [
            {
               detail: @error_object.message
            }
         ]
      }
   end

   def serialize_json_market_vendor
      {
         errors: [   
            {
               detail: @error_object.market_vendor_error_message
            }
         ]
      }
   end
end