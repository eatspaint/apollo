class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :jukeboxes
  has_many :rooms, through: :jukeboxes
  serialize :list, Hash
end
