class ChangeRoomUserIdToString < ActiveRecord::Migration
  def change
    change_column :playlists, :user_id, :string
  end
end
