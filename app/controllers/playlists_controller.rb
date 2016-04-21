class PlaylistsController < ApplicationController
  def show
    user_id = User.find(params[:user]).rspot['id']
    begin
      @playlist = RSpotify::Playlist.find(user_id, params[:playlist])
      room = Room.find(params[:room_id])
      unless room.playlist
        room.create_playlist({rspot_user_id: user_id, rspot_id: @playlist.id})
      end
      @playlist.all_tracks!
      render json: @playlist
    rescue => e
      flash[:error] = "Apollo only works with playlists you own."
      render json: {error: e}
    end
  end

  def check
    room = Room.find(params[:room_id])
    if room_playlist = room.playlist
      user_id = room_playlist.rspot_user_id
      playlist_id = room_playlist.rspot_id
      @playlist = RSpotify::Playlist.find(user_id, playlist_id)
      @playlist.all_tracks!
      render json: @playlist
    else
      if current_user && current_user.rspot != {}
        render json: { exit_message: 'exit' }
      else
        flash[:error] = 'Nobody is currently in that room.'
        render json: { exit_message: 'guest_exit'}
      end
    end
  end

  def create
    user = RSpotify::User.new(current_user.rspot)
    playlist = user.create_playlist!(params[:playlist_name])
    render json: playlist
  end

  def search
    @results = RSpotify::Playlist.search(params[:playlist_query], limit: 50)
    render json: @results
  end

  def song_search
    @results = RSpotify::Track.search(params[:song_query], limit: 50)
    render json: @results
  end

  def add_track
    track = RSpotify::Track.find(params[:song_id])
    if track.name == "Never Gonna Give You Up" && track.artists[0].name == "Rick Astley"
      render json: {error: 'rickroll'}
    else
      user_id = Room.find(params[:room][:id]).playlist.rspot_user_id
      playlist = RSpotify::Playlist.find(user_id, params[:playlist][:id])
      playlist.add_tracks!([track])
      playlist.all_tracks!
      render json: playlist
    end
  end

  def remove_track
    track = RSpotify::Track.find(params[:track_id])
    user_id = Room.find(params[:room][:id]).playlist.rspot_user_id
    playlist = RSpotify::Playlist.find(user_id, params[:playlist][:id])
    playlist.remove_tracks!([{track: track, positions: [params[:position].to_i]}])
    playlist.all_tracks!
    render json: playlist
  end

end
