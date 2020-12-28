class CreateMatchStats < ActiveRecord::Migration[6.0]
  def change
    create_table :match_stats do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :match_id
      t.integer :home_score
      t.integer :away_score
      t.integer :home_total_miss
      t.integer :away_total_miss

      t.timestamps
    end
  end
end
