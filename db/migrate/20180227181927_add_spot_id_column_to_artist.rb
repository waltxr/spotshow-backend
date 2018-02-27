class AddSpotIdColumnToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :spot_id, :string
  end
end
