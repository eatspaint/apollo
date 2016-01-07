class CreateJukeboxes < ActiveRecord::Migration
  def change
    create_table :jukeboxes do |t|
      t.string :name
      t.belongs_to :room
      t.belongs_to :playlist

      t.timestamps null: false
    end
  end
end
