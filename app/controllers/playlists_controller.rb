class PlaylistsController < ApplicationController
  def show
    user_id = User.find(params[:user]).rspot['id']
    begin
      @playlist = RSpotify::Playlist.find(user_id, params[:playlist])
      render json: @playlist
    rescue => e
      flash[:error] = "Apollo only works with playlists you own."
      render json: {error: e}
    end
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
