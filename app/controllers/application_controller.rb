class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if session[:novel_id].present?
      novel_list_path(session[:novel_id].to_i)
    else
      root_path
    end
  end
end
