class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend = User.find(params[:friend_id])
    # merge :user_id into the params
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows_or_same?(@friend)
    redirect_to root_path
  end

  def show
    # through association, remember?!
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises

  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end

end
