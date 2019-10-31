class Api::V1::AuthController < ApplicationController

    def spotify_request
        url = "https://accounts.spotify.com/authorize"

        # DO  NOT CHANGE
        query_params = { 
            client_id: Rails.application.credentials[:spotify][:client_id],
            response_type: 'code',
            redirect_uri: 'https://current-input-front.herokuapp.com/callback',
            scope: "
            playlist-modify-public
            playlist-modify-private 
            playlist-read-collaborative 
            playlist-read-private
            user-library-read 
            user-modify-playback-state 
            user-read-private 
            user-top-read 
            user-follow-modify 
            user-read-recently-played 
            user-read-currently-playing 
            user-read-playback-state 
            ",
            show_dialog: true
        }
        redirect_to "#{url}?#{query_params.to_query}"
    end

end
