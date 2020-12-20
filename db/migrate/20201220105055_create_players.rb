class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :player_ssid
      t.string :name
      t.integer :team_id
      t.string :place
      t.string :birthday
      t.string :height_cm
      t.string :weight_kg
      t.string :photo
      t.string :nbaAge
      t.string :salary
      t.string :number
      t.timestamps
    end
  end
end
