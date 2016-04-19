class Playlist < ActiveRecord::Base
  belongs_to :room, inverse_of: :playlist
end
