class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  layout "application"
  before_filter :set_xframeoption
 
 def set_xframeoption
  response.headers["X-Frame-Options"]='GOFORIT'
 end

 end 




   
