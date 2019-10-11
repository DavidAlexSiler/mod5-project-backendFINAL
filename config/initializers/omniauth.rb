require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :spotify, "49d0c77934b546769d0240ccab401fcb", "b29c034aefc149d499da21a80818caf8", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end