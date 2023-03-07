# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'
RSpotify.authenticate(ENV.fetch("SPOTIFY_CLIENT_ID"), ENV.fetch("SPOTIFY_SECRET"))

user = User.last

Post.destroy_all

# Create three example posts
post1 = Post.create!(
  spotify_track_id: '0u2P5u6lvoDfwTYjAADbn4',
  album_cover_url: 'https://i.scdn.co/image/ab67616d0000b273c9e42bb1ed00e3992e83e468',
  user_id: user.id
)
# post2 = Post.create!(
#   spotify_track_id: '3Zwu2KXhFVSfXmDnFgLf6z',
#   album_cover_url: 'https://i.scdn.co/image/ab67616d0000b2734255dd0e3616d98cf82d5ec8',
#   user_id: user.id
# )
# post3 = Post.create!(
#   spotify_track_id: '2rPE9A1vEgShuZxxzR2tZH',
#   album_cover_url: 'https://i.scdn.co/image/ab67616d0000b27382a57b48a22cf463fac7edda',
#   user_id: user.id
# )

# Print out post details
[post1].each do |post|
  if post.spotify_track_id.present?
    track = RSpotify::Track.find(post.spotify_track_id)
    puts "Track: #{track.name}"
    puts "Artist: #{track.artists.first.name}"
    if post.album_cover_url.present?
      puts "Album Cover URL: #{post.album_cover_url}"
    end
    puts ""
  end
end

# artist1 = RSpotify::Artist.search('Beyoncé').first
# album1 = artist1.albums.first
# Post.create(title: "Love On Top", artist: "Beyoncé", album: album1.name, spotify_id: album1.id)

# artist2 = RSpotify::Artist.search('Taylor Swift').first
# album2 = artist2.albums.first
# Post.create(title: "Blank Space", artist: "Taylor Swift", album: album2.name, spotify_id: album2.id)

# artist3 = RSpotify::Artist.search('Ed Sheeran').first
# album3 = artist3.albums.first
# Post.create(title: "Shape of You", artist: "Ed Sheeran", album: album3.name, spotify_id: album3.id)
