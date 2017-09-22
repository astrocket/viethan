class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(display_name))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(display_name))
  end

  before_action :store_current_location, unless: :devise_controller?
  helper_method :back_url

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(resource)
    stored_location_for(:user) || (respond_to?(:root_path) ? root_path : thredded.root_path)
  end

  def back_url
    session[:user_return_to] || (respond_to?(:root_path) ? root_path : thredded.root_path)
  end

  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:educator_locale] = l
    end
    I18n.locale = l
  end

end
