class Api::V1::UsersController < ApplicationController
    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        # Now you can access user's private data, create playlists and much more

        # Access private data
        spotify_user.country #=> "US"
        spotify_user.email   #=> "example@email.com"

        # Create playlist in user's Spotify account
        playlist = spotify_user.create_playlist!('my-awesome-playlist')

        # Add tracks to a playlist in user's Spotify account
        tracks = RSpotify::Track.search('Know')
        playlist.add_tracks!(tracks)
        playlist.tracks.first.name #=> "Somebody That I Used To Know"

        # Access and modify user's music library
        spotify_user.save_tracks!(tracks)
        spotify_user.saved_tracks.size #=> 20
        spotify_user.remove_tracks!(tracks)

        albums = RSpotify::Album.search('launeddas')
        spotify_user.save_albums!(albums)
        spotify_user.saved_albums.size #=> 10
        spotify_user.remove_albums!(albums)

        # Use Spotify Follow features
        spotify_user.follow(playlist)
        spotify_user.follows?(artists)
        spotify_user.unfollow(users)

        # Get user's top played artists and tracks
        spotify_user.top_artists #=> (Artist array)
        spotify_user.top_tracks(time_range: 'short_term') #=> (Track array)

        # Check doc for more
    end

    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def create
        # Request refresh and access tokens
        
        body = {
        grant_type: "authorization_code",
        code: params[:code]],
        redirect_uri: 'http://localhost:3000/api/v1/user',
        client_id: Rails.application.credentials[:spotify][:client_id],
        client_secret: Rails.application.credentials[:spotify][:client_secret]
        }

        auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
        auth_params = JSON.parse(auth_response.body)
        header = {
        Authorization: "Bearer #{auth_params["access_token"]}"
        }

        user_response = RestClient.get("https://api.spotify.com/v1/me", header)
        user_params = JSON.parse(user_response.body)
        
        #Create User 
        @user = User.find_or_create_by(
        name: user_params["display_name"], 
        spotify_url: user_params["external_urls"]["spotify"],
        href: user_params["href"],
        uri: user_params["uri"],
        spotify_id: user_params["id"])
        
        image = user_params["images"][0] ? user_params["images"][0]["url"] : nil
        country = user_params["country"] ? user_params["country"] : nil

        #Update the user if they have image or country
        @user.update(image: image, country: country)

        #Update the user access/refresh_tokens
        if @user.access_token_expired?
        @user.refresh_access_token
        else
        @user.update(
            access_token: auth_params["access_token"], 
            refresh_token: auth_params["refresh_token"]
        )
        end

        #Redirect to Front End app homepage
        redirect_to "http://localhost:8888/"
    end    

    private

    def user_params
        params.require(:user).permit(:id, :name, :image, :country, :spotify_url, :href, :uri, :spotify_id, :access_token, :refresh_token)
    end
end
