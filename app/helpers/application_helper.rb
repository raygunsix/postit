module ApplicationHelper

  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.timezone.blank?
      dt = dt.in_time_zone(current_user.timezone)
    end
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
