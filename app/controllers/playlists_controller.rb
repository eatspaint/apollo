class PlaylistsController < ApplicationController
  def show
    user_id = User.find(params[:user]).rspot['id']
    begin
      @playlist = RSpotify::Playlist.find(user_id, params[:playlist])
      room = Room.find(params[:room_id])
      room.playlists.create({user_id: user_id, rspot_id: @playlist.id})
      render json: @playlist
    rescue => e
      flash[:error] = "Apollo only works with playlists you own."
      render json: {error: e}
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
    owner = Room.find(params[:room][:id]).user
    owner_rspot = RSpotify::User.new(owner.rspot)
    playlist = RSpotify::Playlist.find(owner_rspot.id, params[:playlist][:id])
    playlist.add_tracks!([track])
    render json: playlist
  end

  def remove_track
    track = RSpotify::Track.find(params[:track_id])
    owner = Room.find(params[:room][:id]).user
    owner_rspot = RSpotify::User.new(owner.rspot)
    playlist = RSpotify::Playlist.find(owner_rspot.id, params[:playlist][:id])
    playlist.remove_tracks!([track])
    render json: playlist
  end

end
