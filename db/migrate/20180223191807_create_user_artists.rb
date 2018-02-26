class CreateUserArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :user_artists do |t|
      t.integer :user_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
