class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authentication

  private

  def authentication
    api_key   = request.headers['Api-Key']
    @token = Token.where(token: api_key).first if api_key
    unless @token
      render json: {errors: [ {code: 401, message: "Not authorized" } ]}, status: :unauthorized
    end
  end
end
