class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_timezone

  def set_timezone
    tz = request.cookies['jstz_time_zone']
    Time.zone = tz unless tz.nil?
  end
end
