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

  def destroy
    @friendship = Friendship.find(params[:id])
    friendname = @friendship.friend.full_name
    if @friendship.destroy
      flash[:notice] = "#{friendname} unfollowed"
    else
      flash[:alert] = "#{friendnamee} could not be unfollowed"
    end
    redirect_to user_exercises_path(current_user)
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end

end
