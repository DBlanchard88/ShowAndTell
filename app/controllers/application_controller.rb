class ApplicationController < ActionController::Base
  before_action :set_notification, if: :current_user

  private


  def set_notification
    notifications = Noticed::Notification.where(recipient: current_user).newest_first.limit(9)

    # Filter unread and read notifications
    @unread = notifications.unread
    @read = notifications.read
  end


end
