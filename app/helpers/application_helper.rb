module ApplicationHelper
  def current_id?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
