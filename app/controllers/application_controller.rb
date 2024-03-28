class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from  ActiveRecord::RecordInvalid, with: :bad_request_response

  private

   def not_found_response(exception)
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
         .serialize_json, status: :not_found
   end

   def bad_request_response(exception)
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
         .serialize_json, status: :bad_request
   end

   def vendor_params
      params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted )
   end
end
