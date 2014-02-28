module ApplicationHelper
  def auth_token
    "<input type='hidden'
      value=#{form_authenticity_token}
      name='authenticity_token'>".html_safe
  end

  def authenticate
    redirect_to new_session_url unless logged_in?
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token
  end

  def logout!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end
end
