class AddRspotIdToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :rspot_id, :string
  end
end
