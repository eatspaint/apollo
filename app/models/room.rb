class Room < ActiveRecord::Base
  belongs_to :user
  has_many :jukeboxes
  has_many :playlists, through: :jukeboxes
  validates :name, uniqueness: { message: "That room name is already taken" }

  def self.wherearewe
    playing, empty = [], []
    Room.all.each do |room|
      if room.playlists.any?
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
