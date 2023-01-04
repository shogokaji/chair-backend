class Api::V1::NotificationsController < ApplicationController

  after_action :notifications_checked, only: %i[ index ]

 def index
   @notifications = current_api_v1_user.passive_notifications
  
   notifications = []
   @notifications.each do |notification|
    notifications << {
      notification: notification,
      user: User.find(notification.visitor_id)
    }
   end
  
    render json:{ status: 200, notifications: notifications}
  end

  def destroy
    notifications = Notification.where(visited_id: params[:id])
    notifications.destroy_all
    render json:{ status: 200, notifications:[] }
  end

    private

    def notifications_checked
      @notifications.where(checked: false).each do |notification|
        notification.update(checked: true)
      end
    end

end
