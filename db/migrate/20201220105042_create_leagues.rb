class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.string :color
      t.string :league_ssid
      t.string :league_name
      t.string :short_name
      t.integer :league_type
      t.string :match_season
      t.integer :country_id
      t.string :country
      t.integer :league_kind
      t.string :logo
      t.string :part_time

      t.timestamps
    end
  end
end
