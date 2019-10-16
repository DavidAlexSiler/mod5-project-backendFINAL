class Playlist < ApplicationRecord
    # user joins
    belongs_to :user
    # musical joins
    has_many :songs, through: :playlist_songs
end
