class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_locale
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
=begin
    # Configure fallbacks for mongoid errors:
    require "i18n/backend/fallbacks"
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.fallbacks = {'fr' => 'en'}
=end

end
