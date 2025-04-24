class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :initialize_cart

  def initialize_cart
    if user_signed_in?
      session[:cart] ||= {}
    end
  end
end
