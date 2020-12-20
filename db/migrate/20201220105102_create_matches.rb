class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :match_ssid
      t.integer :league_id
      t.string :match_timestamp
      t.string :status
      t.string :home_name
      t.string :away_name
      t.integer :home_score
      t.integer :away_score
      t.string :explain_status
      t.boolean :neutral
      t.integer :home_team_id
      t.integer :away_team_id

      t.timestamps
    end
  end
end
