class CreatePlaylistSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_songs do |t|
      t.belongs_to :song, required: false
      t.belongs_to :playlist, required: false

      t.timestamps
    end
  end
end
