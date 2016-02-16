class Room < ActiveRecord::Base
  belongs_to :user
  has_many :jukeboxes
  has_many :playlists, through: :jukeboxes
  validates :name, uniqueness: { message: "That room name is already taken" }
end
