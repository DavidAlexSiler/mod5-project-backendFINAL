class PlaylistSong < ApplicationRecord
    # JOINS
    belongs_to :playlist
    belongs_to :song
end
