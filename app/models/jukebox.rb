class Jukebox < ActiveRecord::Base
  belongs_to :room
  belongs_to :playlist
end
