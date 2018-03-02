class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :venue_id
      t.string :display_name
      t.date :date
      t.time :time
      t.string :uri

      t.timestamps
    end
  end
end
