class Room < ActiveRecord::Base
  belongs_to :user
  has_many :jukeboxes
  has_many :playlists, through: :jukeboxes
  validates :name, uniqueness: { scope: :user, message: "User cannot have two rooms with same name" }
end
