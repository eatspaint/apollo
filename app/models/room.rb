class Room < ActiveRecord::Base
  belongs_to :user
  has_one :playlist, inverse_of: :room
  validates :name, uniqueness: { message: "That room name is already taken" }

  def self.wherearewe
    playing, empty = [], []
    Room.all.each do |room|
      if room.playlist
        playing << "#{room.name}"
      else
        empty << "#{room.name}"
      end
    end
    puts "#{playing.count} rooms contain playlists.\n#{empty.count} rooms are empty.\n"
    puts "-------\nPlaying:\n--------"
    puts playing
    puts "-----\nEmpty:\n------"
    puts empty
  end
end
