require 'rest-client'

class User < ApplicationRecord
    # musical joins
    has_many :playlists
    # self reference join table- 'friends'
    has_many :follows
    has_many :followers, through: :follows



    #REFRESHING TOKENS
    def access_token_expired?
        (Time.now - self.updated_at) > 3300 
    end

    def refresh_access_token
        if access_token_expired?
        body = {
            grant_type: 'refresh_token',
            refresh_token: self.refresh_token,
            client_id: Rails.application.credentials[:spotify][:client_id],
            client_secret: Rails.application.credentials[:spotify][:client_secret]
        }
        auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
        auth_params = JSON.parse(auth_response)
        self.update(access_token: auth_params["access_token"])
        else
        puts "Current Token Has Not Expired"
        end
    end

    def not_following
        @following = self.followees
        @users = User.all
        @not_following = @users - @following
    end
end
