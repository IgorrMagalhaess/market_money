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
      error_message = "Validation Failed: Vendor must exist!"

      if @error_object.message.include?("Market")
         error_message = "Validation Failed: Market must exist!"
      elsif @error_object.message.include?("Vendor")
         error_message = "Validation Failed: Vendor must exist!"
      end

      {
         errors: [
            {
               detail: error_message
            }
         ]
      }
   end

   def serialize_json_already_exits
      {
         errors: [
            {
               detail: @error_object.message.first
            }
         ]
      }
   end
end