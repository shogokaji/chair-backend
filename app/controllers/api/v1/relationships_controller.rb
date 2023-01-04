class Api::V1::RelationshipsController < ApplicationController

  def create
    user = User.find(params[:id])
    current_api_v1_user.follow(user)
    user.create_notification_follow(current_api_v1_user)
    render json:{ status: 200, currentUser: current_api_v1_user.followings,user:user.followers}
  end

  def destroy
    user = User.find(params[:id])
    current_api_v1_user.unfollow(user)
    render json:{ status: 200, currentUser: current_api_v1_user.followings,user:user.followers }
  end

end
