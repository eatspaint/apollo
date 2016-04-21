class RoomsController < ApplicationController
  def index
  end

  def rooms_index
    @rooms = Room.where(user_id: current_user).sort
  end

  def show
    @room = Room.find(Hashids.new('lol', 8).decode(params[:id]).first)
    render_room(@room)
  end

  def render_room(room)
    if room_playlist = room.playlist
      @playlist = RSpotify::Playlist.find(room_playlist.rspot_user_id, room_playlist.rspot_id)
      @playlist.all_tracks!
    end
    @owner = RSpotify::User.new(room.user.rspot)
    @room_salt = params[:id]
    if current_user && current_user.rspot != {}
      user = @owner.id == current_user.rspot['id'] ? @owner : RSpotify::User.new(current_user.rspot)
      @playlists = user.playlists(limit: 50)
    else
      unless room_playlist
        flash[:error] = 'Nobody is currently in that room.'
        redirect_to '/' and return
      end
    end
    render :show
  end

  def find_room
    room = Room.find_by(name: params[:room_name])
    if room
      render json: {room: room, salt: Hashids.new('lol', 8).encode(room.id)}
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
    if params[:room][:name].strip != ''
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
    else
      flash[:error] = "Room name can't be blank."
      render json: {error: 'error'}
    end
  end

  def edit
  end

  def destroy
    Room.find(params[:id]).destroy
    head :ok
  end

  def remove_playlist
    Room.find(params[:room_id]).playlist.destroy
    head :ok
  end

  def rickroll
    room = Room.find(params[:room_id])
    room.update(rickroll: !room.rickroll)
    head :ok
  end

  def rickrolltest
    @room = Room.find_by(name: 'RRGuard Test Room')
    render_room(@room)
  end

  private

  def room_params
    params.require(:room).permit(:name, :status)
  end
end
