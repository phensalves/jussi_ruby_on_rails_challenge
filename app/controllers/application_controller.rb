class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'marvel', password: 'marvel'
  protect_from_forgery with: :exception
end
