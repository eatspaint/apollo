class PlaylistsController < ApplicationController
  def show
    user_id = User.find(params[:user]).rspot['id']
    begin
      @playlist = RSpotify::Playlist.find(user_id, params[:playlist])
      room = Room.find(params[:room_id])
      unless room.playlists.any?
        room.playlists.create({user_id: user_id, rspot_id: @playlist.id})
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
    if room.playlists.any?
      user_id = Room.find(params[:room_id]).playlists.first.user_id
      playlist_id = Room.find(params[:room_id]).playlists.first.rspot_id
      @playlist = RSpotify::Playlist.find(user_id, playlist_id)
      @playlist.all_tracks!
      render json: @playlist
    else
      render json: { exit_message: 'exit' }
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
    user_id = Room.find(params[:room][:id]).playlists.first.user_id
    playlist = RSpotify::Playlist.find(user_id, params[:playlist][:id])
    playlist.add_tracks!([track])
    playlist.all_tracks!
    render json: playlist
  end

  def remove_track
    track = RSpotify::Track.find(params[:track_id])
    user_id = Room.find(params[:room][:id]).playlists.first.user_id
    playlist = RSpotify::Playlist.find(user_id, params[:playlist][:id])
    playlist.remove_tracks!([{track: track, positions: [params[:position].to_i]}])
    playlist.all_tracks!
    render json: playlist
  end

end
