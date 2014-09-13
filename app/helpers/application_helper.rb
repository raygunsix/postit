module ApplicationHelper
  
  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end
end
