class CreateArtistEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_events do |t|
      t.integer :event_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
