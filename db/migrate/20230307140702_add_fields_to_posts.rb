class AddFieldsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :spotify_track_id, :string
    add_column :posts, :album_cover_url, :string
  end
end
