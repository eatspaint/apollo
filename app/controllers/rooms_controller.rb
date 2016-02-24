class RoomsController < ApplicationController
  def index
  end

  def rooms_index
    @rooms = Room.where(user_id: current_user)
  end

  def show
    @room = Room.find(params[:id])
    @owner = RSpotify::User.new(@room.user.rspot)
    if current_user
      user = RSpotify::User.new(current_user.rspot)
      @playlists = user.playlists(limit: 50)
      if @room.playlists.any?
        @playlist = RSpotify::Playlist.find(@room.playlists.first.user_id, @room.playlists.first.rspot_id)
      end
    else
      if @room.playlists.any?
        @playlist = RSpotify::Playlist.find(@room.playlists.first.user_id, @room.playlists.first.rspot_id)
      else
        flash[:error] = 'Nobody is currently in that room.'
        redirect_to '/'
      end
    end
  end

  def find_room
    room = Room.find_by(name: params[:room_name])
    if room
      render json: room
    else
      flash[:error] = 'A room with that name could not be found. (Rooms are case sensitive.)'
      render json: {error: flash}
    end
  end

  def room_show
    @room = Room.find(params[:id])
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.create(room_params)
    if @room.save
      head :ok
    else
      messages = []
      @room.errors.messages.each do |name, message|
        flash[:validation] = message[0]
      end
      render json: {error: messages}
    end
  end

  def edit
  end

  def destroy
    Room.find(params[:id]).destroy
    head :ok
  end

  def remove_playlist
    Room.find(params[:room_id]).playlists.destroy_all
    head :ok
  end

  private

  def room_params
    params.require(:room).permit(:name, :status)
  end
end
