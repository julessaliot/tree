# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

RSpotify.authenticate(ENV.fetch("SPOTIFY_CLIENT_ID"), ENV.fetch("SPOTIFY_SECRET"))

Post.destroy_all

def create_posts
  # Search for a few different tracks to use in posts
  track1 = RSpotify::Track.search('Paradise City', limit: 1).first
  track2 = RSpotify::Track.search('Smells Like Teen Spirit', limit: 1).first
  track3 = RSpotify::Track.search('Bohemian Rhapsody', limit: 1).first

  # Create 3 posts using the tracks and some sample text
  Post.create(content: "Just discovered this amazing track by #{track1.artists.first.name}! 🤘🎸",
              user_id: 1, spotify_track_id: track1.id,
              album_cover_url: track1.album.images.first["url"])
  Post.create(content: "Can't get enough of #{track2.name} by #{track2.artists.first.name}! 🤟🎤",
              user_id: 1, spotify_track_id: track2.id,
              album_cover_url: track2.album.images.first["url"])

  Post.create(content: "Feeling nostalgic listening to #{track3.name} by #{track3.artists.first.name}! 🎶🕺",
              user_id: 1, spotify_track_id: track3.id,
              album_cover_url: track3.album.images.first["url"])
end

create_posts
