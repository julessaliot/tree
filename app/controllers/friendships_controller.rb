class FriendshipsController < ApplicationController
  def create
    @receiver = User.find(params[:user_id])
    @friendship = Friendship.new
    @friendship.receiver = @receiver
    @friendship.asker = current_user
  end

  def destroy
    @friend = User.find(params[:user_id])
    @friendship = Friendship.where(receiver: current_user).where(asker: @friend) ||
                  Friendship.where(receiver: @friend).where(asker: current_user)
    @friendship.destroy
  end
end
