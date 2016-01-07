class UsersController < ApplicationController
  def show
  end

  def new
  end

  def edit
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth']).to_hash
    current_user.update(rspot: spotify_user)
    redirect_to '/'
  end
end
