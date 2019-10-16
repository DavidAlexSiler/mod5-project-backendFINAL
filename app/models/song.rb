class Song < ApplicationRecord
    # musical joins
    has_many :playlist_songs
    # user joins
    has_many :playlists, through: :playlist_song
end
