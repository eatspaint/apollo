class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.text :list
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
