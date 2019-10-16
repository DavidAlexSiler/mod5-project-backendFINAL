class Api::V1::PlaylistController < ApplicationController
    def index
        @playlists = Playlist.all
        render json: @playlist
    end

    def show
        @playlist = Playlist.find_by(id: params[:id])
    end

    def new
        @playlist = Playlist.new
    end

    def create
        @playlist = Playlist.create(playlist_params)
    end

    def edit
        @playlist = Playlist.find_by(id: params[:id])
    end

    def update
        @playlist = Playlist.find_by(id: params[:id])
        @playlist.update
    end

    def destroy
        @playlist = Playlist.find_by(id: params[:id])
        @playlist.destroy
    end



    private 
        def playlist_params
            params.require(:playlist).permit(:title, :owner, :image, :description, :collaborative, :public, :followers, :length)
        end
end
