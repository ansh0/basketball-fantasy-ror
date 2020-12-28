class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.integer :team_id
      t.integer :match_id
      t.integer :player_id
      t.string :location
      t.integer :play_time
      t.integer :shoot_hit
      t.integer :shooot
      t.integer :three_point_hit
      t.integer :three_point_shoot
      t.integer :penalty_shot_hit
      t.integer :penalty_shot
      t.integer :attack
      t.integer :foul
      t.integer :rob
      t.integer :miss
      t.integer :cover
      t.integer :score
      t.boolean :on_floor

      t.timestamps
    end
  end
end
