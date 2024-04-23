class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :authenticate!

  attr_reader :current_user, :handle_not_found

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by_token(token)
    end
  end

  def handle_not_found
    render json: { message: "Record not found." }, status: :not_found
  end
end
