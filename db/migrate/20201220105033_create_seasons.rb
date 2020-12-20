class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :season_ssid
      t.string :season_name
      t.integer :league_id
      t.integer :group_count
      t.integer :round_count
      t.integer :sort_number
      t.boolean :current_group
      t.boolean :group

      t.timestamps
    end
  end
end
