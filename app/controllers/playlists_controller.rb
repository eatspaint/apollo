class PlaylistsController < ApplicationController
  def show
    user_id = User.find(params[:user]).rspot['id']
    @playlist = RSpotify::Playlist.find(user_id, params[:playlist])
    render json: @playlist
  end

  def new
  end

  def edit
  end

  def search
    @results = RSpotify::Playlist.search(params[:playlist_query], limit: 50)
    render json: @results
  end

end
