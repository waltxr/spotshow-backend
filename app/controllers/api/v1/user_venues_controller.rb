class Api::V1::UserVenuesController < ApplicationController
  skip_before_action :authorized, only: [:create, :show, :destroy]

  def create
    encrypted_user_id = params["jwt"]
    user_id = JWT.decode(encrypted_user_id, ENV["MY_SECRET"], ENV["ALG"])
    @user = User.find_by(id: user_id[0]["user_id"])

    venue = Venue.find(params["user_venue"]["id"])
    @user.add_favorite_venue(venue)

    render json: @user.favorite_venues
  end

  def show

    encrypted_user_id = params["jwt"]
    user_id = JWT.decode(encrypted_user_id, ENV["MY_SECRET"], ENV["ALG"])
    @user = User.find(user_id[0]["user_id"])

    render json: @user.favorite_venues
  end

  def destroy
    encrypted_user_id = params["jwt"]
    user_id = JWT.decode(encrypted_user_id, ENV["MY_SECRET"], ENV["ALG"])
    @user = User.find(user_id[0]["user_id"])
    user_venue = UserVenue.find_by(user: @user, venue: params["id"])
    user_venue.destroy

    render json: @user.favorite_venues
  end

end
