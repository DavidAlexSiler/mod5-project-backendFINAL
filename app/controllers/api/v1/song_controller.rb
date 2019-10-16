class Api::V1::SongController < ApplicationController

    def index
        @songs = Song.all
        render json: @song
    end

    def show
        @song = Song.find_by(id: params[:id])
    end

    def new
        @song = Song.new
    end

    def create
        body = {
            grant_type: "authorization_code",
            code: params[:code],
            redirect_uri: 'http://localhost:8888/callback',
            client_id: Rails.application.credentials[:spotify][:client_id],
            client_secret: Rails.application.credentials[:spotify][:client_secret]
        }

        # GET ACCESS TOKEN

        auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
        auth_params = JSON.parse(auth_response.body)
        header = {
            Authorization: "Bearer #{auth_params["access_token"]}"
        }
        
        song_response = RestClient.get("https://api.spotify.com/v1/search", header)
        song_params = JSON.parse(user_response.body)
        
        #Create Song 
        @song = Song.find_or_create_by(
            title:  song_params["name"]
            artist: song_params["artist"]
            album: song_params["album"]
            album_img: song_params["images"][0]
        )
        if @song 
            @song.access_token = auth_params["access_token"]
                if @song.access_token_expired?
                @song.refresh_access_token
                else
                @song.update(
                    access_token: auth_params["access_token"], 
                    refresh_token: auth_params["refresh_token"]
                )
            end
            #Redirect to Front End app homepage checked
            render json: @song
        else
            render json: {error: "invalid stuff"}
        end
        
    end

    def edit
        @song = Song.find_by(id: params[:id])
    end

    def update
        @song = Song.find_by(id: params[:id])
        @song.update
    end

    def destroy
        @song = Song.find_by(id: params[:id])
        @song.destroy
    end



    private 
        def song_params
            params.require(:song).permit(:title, :artist, :album, :album_img)
        end
end
