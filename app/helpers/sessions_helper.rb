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

end
