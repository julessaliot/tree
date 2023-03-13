class FriendshipsController < ApplicationController
  before_action :find_friendship, only: %i[edit update destroy]

  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship.receiver = @receiver
    @friendship.asker = current_user

    @friendship = current_user.friendship.build(friendship_params)
    return unless @friendship.save

    flash[:notice] = "Friendship request has been sent."
    redirect_back fallback_location: user_friendships_path
  end

  def edit; end

  def update
    return unless @friendship.update(friendship_params)

    flash[:notice] = "Friendship request has been updated."
    redirect_back fallback_location: user_friendships_path
  end

  def destroy
    @friendship = Friendship.where(receiver: current_user).where(asker: @friend) ||
                  Friendship.where(receiver: @friend).where(asker: current_user)
    @friendship.destroy

    flash[:notice] = "Friendship request has been deleted."
    redirect_back fallback_location: user_friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:receiver, :asker, :status)
  end

  def find_friendship
    @friendship = Friendship.find(params[:id])
  end
end
