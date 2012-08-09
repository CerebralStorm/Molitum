class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
