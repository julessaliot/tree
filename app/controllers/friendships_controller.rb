class FriendshipsController < ApplicationController
  before_action :find_friendship, only: %i[edit update destroy accept reject]

  def new
    @friendship = Friendship.new
  end

  def index
    @pending_friendships = current_user.pending_friendships_received
    @accepted_friendships = current_user.accepted_friendships
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.asker = current_user
    @friendship.save

    redirect_to user_friendships_path
  end

  def accept
    @friendship.accepted!

    redirect_to friendships_path
  end

  def reject
    @friendship.rejected!

    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:receiver)
  end

  def find_friendship
    @friendship = Friendship.find(params[:id])
  end
end
