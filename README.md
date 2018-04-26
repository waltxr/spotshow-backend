## SpotShow
A useful tool that provides you with a list of concerts in NYC for artists that are saved to your Spotify library.

[Demo](https://www.youtube.com/watch?v=Nl-b1-FSCXg&feature=youtu.be)

## Inspiration
When viewing an artist's page in Spotify you'll notice a list of the artist's shows booked in your area. I decided to build a tool that displays all shows in NYC for any artist a user has saved to your Spotify library. In addition I wanted to be able to save a list of venues and enable a user to view a feed of shows for artists they like by venue.

## Features
1. Login with your Spotify account.
2. View a list of shows happening in NYC for artists that you have saved to your Spotify Library .
3. Save a list of Favorite Venues so you can view what shows are happening by artits you've saved by venue.

## Installation
SpotShow was built using Ruby on Rails for the backend and React/Redux for the frontend. To install locally make sure you follow the instructions for the frontend repo located [here](https://github.com/Waltxr/spotshow-frontend). First fork/clone this repo and run:
 `bundle install`
 `rake db:migrate`
 `rake db:seed`
 `rails s`

## The Code
SpotShow was made with a rails API backend and React/Redux frontend. Some highlights:

1. Used Spotify's API documentation to create OAuth flow that allows users to login with their Spotify account and authorizes SpotShow to pull their saved artists. [Spotify API](https://beta.developer.spotify.com/documentation/web-api/)

2. Populated database with show information for NYC from SongKick. [Songkick API](https://www.songkick.com/developer)

3.  Cross referenced users saved artists from Spotify with artists playing shows in NYC in backend. Provided API routes for frontend to access to concerts and saved venues:
  - api_v1_login GET                  /api/v1/login(.:format)                 api/v1/logins#create
  - api_v1_dashboard POST             /api/v1/dashboard(.:format)             api/v1/users#create
  - api_v1_events POST                /api/v1/events(.:format)                api/v1/users#show
  - api_v1_favorite_venues POST       /api/v1/favorite_venues(.:format)       api/v1/user_venues#create
  - api_v1_get_favorite_venues POST   /api/v1/get_favorite_venues(.:format)   api/v1/user_venues#show
  - api_v1 DELETE                     /api/v1/favorite_venues/:id(.:format)   api/v1/user_venues#destroy
  - api_v1_get_user POST              /api/v1/get_user(.:format)              api/v1/logins#show

## Screenshots
![Home](./img/home.jpg?raw=true "Home Screen")

![Login](./img/login.jpg?raw=true "Login with Spotify")

![Dashboard](./img/dashboard.jpg?raw=true "Dashboard")

![Favorite Venues](./img/favorite-venues.jpg?raw=true "Favorite Venues")

## Authors
Adam Walter - @Waltxr

## License
MIT Copyright 2018
