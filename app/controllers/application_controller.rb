class ApplicationController < ActionController::API
  include ApiM8::Authentication::ControllerMethods
  include ApiM8::JsonAPI::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

end
