class AddRickrollToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :rickroll, :boolean
  end
end
