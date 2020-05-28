class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    notification = Notification.find params[:id]

    if notification.novel_list.user_id != current_user.id
      return
    end

    @id = notification.id
    notification.destroy
  end

  def all_delete
    Notification.where(user_id: current_user.id).destroy_all
    redirect_back(fallback_location: root_path)
  end
end
