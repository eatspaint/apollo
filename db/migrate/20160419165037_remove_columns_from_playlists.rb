class RemoveColumnsFromPlaylists < ActiveRecord::Migration
  def change
    # Remove unused columns on playlists
    remove_column :playlists, :list
    remove_column :playlists, :name

    # Make playlist user more clear
    rename_column :playlists, :user_id, :rspot_user_id

    # make playlists belong directly to rooms
    add_reference :playlists, :room, index: true

    # remove need for jukeboxes, move room_id to playlist
    # Playlist.find_each do |playlist|
    #   if room = playlist.rooms.first
    #     playlist.room_id = room.id
    #     playlist.save!
    #   end
    # end

    # remove jukeboxes table entirely
    drop_table :jukeboxes

    # remove unused column from rooms
    remove_column :rooms, :status
  end
end
