class Api::V1::LoginsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    query_params = {
      client_id: ENV["CLIENT_ID"],
      response_type: "code",
      redirect_uri: ENV["REDIRECT_URI"],
      scope: "user-library-read user-library-modify user-top-read user-modify-playback-state playlist-modify-public playlist-modify-private",
      show_dialog: true
    }
    url = "https://accounts.spotify.com/authorize"
    redirect_to "#{url}?#{query_params.to_query}"
  end

  def show
    encrypted_user_id = params["jwt"]
    user_id = JWT.decode(encrypted_user_id, ENV["MY_SECRET"], ENV["ALG"])
    @user = User.find_by(id: user_id[0]["user_id"])

    render json: {currentUser: @user}
  end

end
