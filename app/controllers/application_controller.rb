class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :initialize_cart

  def initialize_cart
    if user_signed_in?
      session[:cart] ||= {}
    end
  end
end
