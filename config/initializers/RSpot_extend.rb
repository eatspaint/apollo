class RSpotify::Playlist
  attr_accessor :all_tracks
end

module Tracks
  def all_tracks!
    length = self.total
    @all_tracks = self.tracks_cache
    offset = 100
    while @all_tracks.length != length
      @all_tracks += self.tracks(offset: offset)
      offset += 100
    end
  end
end

RSpotify::Playlist.include Tracks
