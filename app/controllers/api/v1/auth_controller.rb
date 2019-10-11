class Api::V1::AuthController < ApplicationController
    def spotify_request
        url = "https://accounts.spotify.com/authorize"
        
        query_params = { 
            client_id: Rails.application.credentials[:spotify][:client_id],
            response_type: 'code',
            redirect_uri: 'http://localhost:8888/callback',
            scope: "user-library-read 
            playlist-read-collaborative
            playlist-modify-private
            user-modify-playback-state
            user-read-private
            user-top-read
            playlist-modify-public",
            show_dialog: true
        }
        redirect_to "#{url}?#{query_params.to_query}"
        # redirect_to "http://localhost:8888/callback"
    end

end
