class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :team_ssid
      t.string :short_name
      t.string :logo
      t.string :website
      t.string :conference
      t.string :division
      t.string :city
      t.string :venue
      t.string :capacity
      t.integer :join_year
      t.integer :champion_count
      t.string :coach
      t.integer :league_id

      t.timestamps
    end
  end
end
