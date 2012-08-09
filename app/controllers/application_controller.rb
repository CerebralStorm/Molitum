class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    sign_up2_path(current_user)
  end

end
