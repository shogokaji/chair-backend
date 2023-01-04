class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController

  def index
    if current_api_v1_user
      follows = current_api_v1_user.followings
      followers = current_api_v1_user.followers
      notification = current_api_v1_user.passive_notifications.where(checked: false).count
      render json: {status:200 ,current_user: current_api_v1_user ,follows: follows, followers: followers, notification: notification }
    else
      render json: {status: 500, message: "ユーザーが存在しません"}
    end
  end

  def guest_sign_in
    @resource = User.guest 
    @token = @resource.create_token
    @resource.save!
    user = render_create_success
  end

end
