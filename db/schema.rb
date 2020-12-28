# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_27_063507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "color"
    t.string "league_ssid"
    t.string "league_name"
    t.string "short_name"
    t.integer "league_type"
    t.string "match_season"
    t.integer "country_id"
    t.string "country"
    t.integer "league_kind"
    t.string "logo"
    t.string "part_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "match_stats", force: :cascade do |t|
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "match_id"
    t.integer "home_score"
    t.integer "away_score"
    t.integer "home_total_miss"
    t.integer "away_total_miss"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string "match_ssid"
    t.integer "league_id"
    t.string "match_timestamp"
    t.string "status"
    t.string "home_name"
    t.string "away_name"
    t.integer "home_score"
    t.integer "away_score"
    t.string "explain_status"
    t.boolean "neutral"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "player_stats", force: :cascade do |t|
    t.integer "team_id"
    t.integer "match_id"
    t.integer "player_id"
    t.string "location"
    t.integer "play_time"
    t.integer "shoot_hit"
    t.integer "shooot"
    t.integer "three_point_hit"
    t.integer "three_point_shoot"
    t.integer "penalty_shot_hit"
    t.integer "penalty_shot"
    t.integer "attack"
    t.integer "foul"
    t.integer "rob"
    t.integer "miss"
    t.integer "cover"
    t.integer "score"
    t.boolean "on_floor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "player_ssid"
    t.string "name"
    t.integer "team_id"
    t.string "place"
    t.string "birthday"
    t.string "height_cm"
    t.string "weight_kg"
    t.string "photo"
    t.string "nbaAge"
    t.string "salary"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.string "season_ssid"
    t.string "season_name"
    t.integer "league_id"
    t.integer "group_count"
    t.integer "round_count"
    t.integer "sort_number"
    t.boolean "current_group"
    t.boolean "group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "team_ssid"
    t.string "short_name"
    t.string "logo"
    t.string "website"
    t.string "conference"
    t.string "division"
    t.string "city"
    t.string "venue"
    t.string "capacity"
    t.integer "join_year"
    t.integer "champion_count"
    t.string "coach"
    t.integer "league_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
