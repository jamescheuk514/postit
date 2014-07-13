module SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    @current_user == user
  end
  def logged_in?
    !!current_user
  end

  def signed_in_user
    unless logged_in?
      flash[:warning] = "You must log in"
      redirect_to root_path ##TODO: redirect to saveed location
    end
  end

  def request_admin
    access_denied unless logged_in? && current_user.admin?
  end

  def access_denied
    flash[:warning] = "You can't do that."
    redirect_to :back
  end
end
