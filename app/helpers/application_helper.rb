module ApplicationHelper
  def current_member
    current_admin || current_user
  end
end
