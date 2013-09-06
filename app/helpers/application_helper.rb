module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def next_wday(n)
    t = Date.today
    t + (n - t.wday) % 7
  end
end
