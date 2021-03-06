# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_29_213843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "architects", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "architects_buildings", id: false, force: :cascade do |t|
    t.integer "architect_id", null: false
    t.integer "building_id", null: false
    t.index ["architect_id", "building_id"], name: "architects_buildings_index", unique: true
  end

  create_table "audits", id: :serial, force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.datetime "created_at"
    t.string "comment"
    t.string "remote_address"
    t.integer "associated_id"
    t.string "associated_type"
    t.string "request_uuid"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "building_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "city", default: "Ithaca", null: false
    t.string "state", default: "NY", null: false
    t.string "postal_code", default: "14850", null: false
    t.integer "year_earliest"
    t.integer "year_latest"
    t.integer "building_type_id"
    t.text "description"
    t.decimal "lat", precision: 15, scale: 10
    t.decimal "lon", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "year_earliest_circa", default: false
    t.boolean "year_latest_circa", default: false
    t.string "address_house_number"
    t.string "address_street_prefix"
    t.string "address_street_name"
    t.string "address_street_suffix"
    t.float "stories"
    t.text "annotations"
    t.integer "lining_type_id"
    t.integer "frame_type_id"
    t.string "block_number"
    t.integer "created_by_id"
    t.integer "reviewed_by_id"
    t.datetime "reviewed_at"
    t.boolean "investigate", default: false
    t.string "investigate_reason"
    t.text "notes"
    t.index ["building_type_id"], name: "index_buildings_on_building_type_id"
    t.index ["created_by_id"], name: "index_buildings_on_created_by_id"
    t.index ["frame_type_id"], name: "index_buildings_on_frame_type_id"
    t.index ["lining_type_id"], name: "index_buildings_on_lining_type_id"
    t.index ["reviewed_by_id"], name: "index_buildings_on_reviewed_by_id"
  end

  create_table "buildings_photos", id: false, force: :cascade do |t|
    t.integer "building_id"
    t.integer "photo_id"
  end

  create_table "census_1900_records", id: :serial, force: :cascade do |t|
    t.jsonb "data"
    t.integer "building_id"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.integer "reviewed_by_id"
    t.datetime "reviewed_at"
    t.integer "page_number"
    t.string "page_side", limit: 1
    t.integer "line_number"
    t.string "county", default: "Tompkins"
    t.string "city", default: "Ithaca"
    t.string "state", default: "NY"
    t.string "ward"
    t.string "enum_dist"
    t.string "street_prefix"
    t.string "street_name"
    t.string "street_suffix"
    t.string "street_house_number"
    t.string "dwelling_number"
    t.string "family_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "relation_to_head"
    t.string "sex", limit: 1
    t.string "race", limit: 1
    t.integer "birth_month"
    t.integer "birth_year"
    t.integer "age"
    t.string "marital_status", limit: 2
    t.integer "years_married"
    t.integer "num_children_born"
    t.integer "num_children_alive"
    t.string "pob", default: "New York"
    t.string "pob_father", default: "New York"
    t.string "pob_mother", default: "New York"
    t.integer "year_immigrated"
    t.string "naturalized_alien"
    t.integer "years_in_us"
    t.string "profession"
    t.integer "unemployed_months"
    t.boolean "attended_school_old"
    t.boolean "can_read"
    t.boolean "can_write"
    t.boolean "can_speak_english"
    t.string "owned_or_rented", limit: 10
    t.string "mortgage", limit: 1
    t.string "farm_or_house", limit: 1
    t.string "language_spoken", default: "English"
    t.text "notes"
    t.boolean "provisional", default: false
    t.boolean "foreign_born", default: false
    t.boolean "taker_error", default: false
    t.integer "attended_school"
    t.string "industry"
    t.integer "farm_schedule"
    t.string "name_prefix"
    t.string "name_suffix"
    t.index ["building_id"], name: "index_census_1900_records_on_building_id"
    t.index ["data"], name: "index_census_1900_records_on_data", using: :gin
    t.index ["person_id"], name: "index_census_1900_records_on_person_id"
  end

  create_table "census_1910_records", id: :serial, force: :cascade do |t|
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "building_id"
    t.integer "created_by_id"
    t.integer "reviewed_by_id"
    t.datetime "reviewed_at"
    t.integer "person_id"
    t.integer "page_number"
    t.string "page_side", limit: 1
    t.integer "line_number"
    t.string "county", default: "Tompkins"
    t.string "city", default: "Ithaca"
    t.string "state", default: "NY"
    t.string "ward"
    t.string "enum_dist"
    t.string "street_prefix"
    t.string "street_name"
    t.string "street_suffix"
    t.string "street_house_number"
    t.string "dwelling_number"
    t.string "family_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "relation_to_head"
    t.string "sex", limit: 1
    t.string "race", limit: 1
    t.integer "age"
    t.string "marital_status", limit: 2
    t.integer "years_married"
    t.integer "num_children_born"
    t.integer "num_children_alive"
    t.string "pob", default: "New York"
    t.string "pob_father", default: "New York"
    t.string "pob_mother", default: "New York"
    t.integer "year_immigrated"
    t.string "naturalized_alien"
    t.string "profession"
    t.string "industry"
    t.string "employment"
    t.boolean "unemployed"
    t.boolean "attended_school"
    t.boolean "can_read"
    t.boolean "can_write"
    t.boolean "can_speak_english"
    t.string "owned_or_rented", limit: 10
    t.string "mortgage", limit: 1
    t.string "farm_or_house", limit: 1
    t.string "num_farm_sched"
    t.string "language_spoken", default: "English"
    t.string "unemployed_weeks_1909"
    t.boolean "civil_war_vet_old"
    t.boolean "blind", default: false
    t.boolean "deaf_dumb", default: false
    t.text "notes"
    t.string "civil_war_vet", limit: 2
    t.boolean "provisional", default: false
    t.boolean "foreign_born", default: false
    t.boolean "taker_error", default: false
    t.string "name_prefix"
    t.string "name_suffix"
    t.index ["building_id"], name: "index_census_1910_records_on_building_id"
    t.index ["created_by_id"], name: "index_census_1910_records_on_created_by_id"
    t.index ["data"], name: "index_census_1910_records_on_data", using: :gin
    t.index ["reviewed_by_id"], name: "index_census_1910_records_on_reviewed_by_id"
  end

  create_table "census_1920_records", id: :serial, force: :cascade do |t|
    t.integer "created_by_id"
    t.integer "reviewed_by_id"
    t.datetime "reviewed_at"
    t.integer "page_number"
    t.string "page_side", limit: 1
    t.integer "line_number"
    t.string "county", default: "Tompkins"
    t.string "city", default: "Ithaca"
    t.string "state", default: "NY"
    t.string "ward"
    t.string "enum_dist"
    t.string "street_prefix"
    t.string "street_name"
    t.string "street_suffix"
    t.string "street_house_number"
    t.string "dwelling_number"
    t.string "family_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "relation_to_head"
    t.string "sex", limit: 1
    t.string "race", limit: 1
    t.integer "age"
    t.string "marital_status", limit: 2
    t.integer "year_immigrated"
    t.string "naturalized_alien"
    t.string "pob", default: "New York"
    t.string "mother_tongue"
    t.string "pob_father", default: "New York"
    t.string "mother_tongue_father"
    t.string "pob_mother", default: "New York"
    t.string "mother_tongue_mother"
    t.boolean "can_speak_english"
    t.string "profession"
    t.string "industry"
    t.string "employment"
    t.boolean "attended_school"
    t.boolean "can_read"
    t.boolean "can_write"
    t.string "owned_or_rented", limit: 10
    t.string "mortgage", limit: 1
    t.string "farm_or_house", limit: 1
    t.text "notes"
    t.boolean "provisional", default: false
    t.boolean "foreign_born", default: false
    t.boolean "taker_error", default: false
    t.integer "person_id"
    t.integer "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name_prefix"
    t.string "name_suffix"
    t.integer "year_naturalized"
    t.integer "farm_schedule"
    t.index ["building_id"], name: "index_census_1920_records_on_building_id"
    t.index ["person_id"], name: "index_census_1920_records_on_person_id"
  end

  create_table "census_1930_records", id: :serial, force: :cascade do |t|
    t.integer "building_id"
    t.integer "person_id"
    t.integer "created_by_id"
    t.integer "reviewed_by_id"
    t.datetime "reviewed_at"
    t.integer "page_number"
    t.string "page_side", limit: 1
    t.integer "line_number"
    t.string "county", default: "Tompkins"
    t.string "city", default: "Ithaca"
    t.string "state", default: "NY"
    t.string "ward"
    t.string "enum_dist"
    t.string "street_prefix"
    t.string "street_name"
    t.string "street_suffix"
    t.string "street_house_number"
    t.string "dwelling_number"
    t.string "family_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "relation_to_head"
    t.string "owned_or_rented", limit: 10
    t.integer "home_value"
    t.boolean "has_radio"
    t.boolean "lives_on_farm"
    t.string "sex", limit: 1
    t.string "race", limit: 1
    t.integer "age"
    t.string "marital_status", limit: 2
    t.integer "age_married"
    t.boolean "attended_school"
    t.boolean "can_read_write"
    t.string "pob", default: "New York"
    t.string "pob_father", default: "New York"
    t.string "pob_mother", default: "New York"
    t.string "pob_code"
    t.string "pob_father_code"
    t.string "pob_mother_code"
    t.string "mother_tongue"
    t.integer "year_immigrated"
    t.string "naturalized_alien"
    t.boolean "can_speak_english"
    t.string "profession"
    t.string "industry"
    t.string "profession_code"
    t.string "worker_class"
    t.boolean "worked_yesterday"
    t.string "unemployment_line"
    t.boolean "veteran"
    t.string "war_fought"
    t.string "farm_schedule"
    t.text "notes"
    t.boolean "provisional", default: false
    t.boolean "foreign_born", default: false
    t.boolean "taker_error", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name_prefix"
    t.string "name_suffix"
    t.index ["building_id"], name: "index_census_1930_records_on_building_id"
    t.index ["created_by_id"], name: "index_census_1930_records_on_created_by_id"
    t.index ["person_id"], name: "index_census_1930_records_on_person_id"
    t.index ["reviewed_by_id"], name: "index_census_1930_records_on_reviewed_by_id"
  end

  create_table "client_applications", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "support_url"
    t.string "callback_url"
    t.string "key", limit: 20
    t.string "secret", limit: 40
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "index_client_applications_on_key", unique: true
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "title", limit: 50, default: ""
    t.text "comment", default: ""
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "construction_materials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gcps", id: :serial, force: :cascade do |t|
    t.integer "map_id"
    t.float "x"
    t.float "y"
    t.decimal "lat", precision: 15, scale: 10
    t.decimal "lon", precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "soft", default: false
    t.string "name"
    t.index ["soft"], name: "index_gcps_on_soft"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_maps", id: :serial, force: :cascade do |t|
    t.integer "group_id"
    t.integer "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["map_id", "group_id"], name: "index_groups_maps_on_map_id_and_group_id", unique: true
    t.index ["map_id"], name: "index_groups_maps_on_map_id"
  end

  create_table "imports", id: :serial, force: :cascade do |t|
    t.string "path"
    t.string "name"
    t.string "layer_title"
    t.string "map_title_suffix"
    t.string "map_description"
    t.string "map_publisher"
    t.string "map_author"
    t.string "state"
    t.integer "layer_id"
    t.integer "uploader_user_id"
    t.integer "user_id"
    t.integer "file_count"
    t.integer "imported_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "layers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "bbox"
    t.integer "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "depicts_year", limit: 4, default: ""
    t.integer "maps_count", default: 0
    t.integer "rectified_maps_count", default: 0
    t.boolean "is_visible", default: true
    t.string "source_uri"
    t.geometry "bbox_geom", limit: {:srid=>4326, :type=>"st_polygon"}
    t.index ["bbox_geom"], name: "index_layers_on_bbox_geom", using: :gist
  end

  create_table "layers_maps", id: :serial, force: :cascade do |t|
    t.integer "layer_id"
    t.integer "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["layer_id"], name: "index_layers_maps_on_layer_id"
    t.index ["map_id"], name: "index_layers_maps_on_map_id"
  end

  create_table "maps", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "filename"
    t.integer "width"
    t.integer "height"
    t.integer "status"
    t.integer "mask_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "upload_file_name"
    t.string "upload_content_type"
    t.integer "upload_file_size"
    t.datetime "upload_file_updated_at"
    t.string "bbox"
    t.string "publisher"
    t.string "authors"
    t.string "scale"
    t.datetime "published_date"
    t.datetime "reprint_date"
    t.integer "owner_id"
    t.boolean "public", default: true
    t.boolean "downloadable", default: true
    t.string "cached_tag_list"
    t.integer "map_type", default: 1
    t.string "source_uri"
    t.geometry "bbox_geom", limit: {:srid=>4236, :type=>"st_polygon"}
    t.decimal "rough_lat", precision: 15, scale: 10
    t.decimal "rough_lon", precision: 15, scale: 10
    t.geometry "rough_centroid", limit: {:srid=>4326, :type=>"st_point"}
    t.integer "rough_zoom"
    t.integer "rough_state"
    t.integer "import_id"
    t.string "publication_place"
    t.string "subject_area"
    t.string "unique_id"
    t.string "metadata_projection"
    t.decimal "metadata_lat", precision: 15, scale: 10
    t.decimal "metadata_lon", precision: 15, scale: 10
    t.string "date_depicted", limit: 4, default: ""
    t.string "call_number"
    t.datetime "rectified_at"
    t.datetime "gcp_touched_at"
    t.text "mask_geojson"
    t.index ["bbox_geom"], name: "index_maps_on_bbox_geom", using: :gist
    t.index ["rough_centroid"], name: "index_maps_on_rough_centroid", using: :gist
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "my_maps", id: :serial, force: :cascade do |t|
    t.integer "map_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["map_id", "user_id"], name: "index_my_maps_on_map_id_and_user_id", unique: true
    t.index ["map_id"], name: "index_my_maps_on_map_id"
  end

  create_table "oauth_nonces", id: :serial, force: :cascade do |t|
    t.string "nonce"
    t.integer "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["nonce", "timestamp"], name: "index_oauth_nonces_on_nonce_and_timestamp", unique: true
  end

  create_table "oauth_tokens", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "type", limit: 20
    t.integer "client_application_id"
    t.string "token", limit: 20
    t.string "secret", limit: 40
    t.string "callback_url"
    t.string "verifier", limit: 20
    t.datetime "authorized_at"
    t.datetime "invalidated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["token"], name: "index_oauth_tokens_on_token", unique: true
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "sex", limit: 1
    t.string "race", limit: 1
  end

  create_table "people_photos", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "photo_id"
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "building_id"
    t.integer "position"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_size"
    t.integer "width"
    t.integer "height"
    t.text "caption"
    t.integer "year_taken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_photos_on_building_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "street_conversions", force: :cascade do |t|
    t.string "from_prefix"
    t.string "to_prefix"
    t.string "from_name"
    t.string "to_name"
    t.string "from_suffix"
    t.string "to_suffix"
    t.string "from_city"
    t.string "to_city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.datetime "created_at"
    t.string "context", limit: 128
    t.integer "tagger_id"
    t.string "tagger_type"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.string "reset_password_token"
    t.boolean "enabled", default: true
    t.integer "updated_by"
    t.text "description", default: ""
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "reset_password_sent_at"
    t.string "provider"
    t.string "uid"
  end

  add_foreign_key "buildings", "building_types"
  add_foreign_key "buildings", "users", column: "created_by_id"
  add_foreign_key "buildings", "users", column: "reviewed_by_id"
  add_foreign_key "buildings_photos", "buildings"
  add_foreign_key "buildings_photos", "photos"
  add_foreign_key "census_1900_records", "buildings"
  add_foreign_key "census_1900_records", "people"
  add_foreign_key "census_1900_records", "users", column: "created_by_id"
  add_foreign_key "census_1900_records", "users", column: "reviewed_by_id"
  add_foreign_key "census_1910_records", "buildings"
  add_foreign_key "census_1910_records", "people"
  add_foreign_key "census_1910_records", "users", column: "created_by_id"
  add_foreign_key "census_1910_records", "users", column: "reviewed_by_id"
  add_foreign_key "census_1920_records", "buildings"
  add_foreign_key "census_1920_records", "people"
  add_foreign_key "census_1920_records", "users", column: "created_by_id"
  add_foreign_key "census_1920_records", "users", column: "reviewed_by_id"
  add_foreign_key "census_1930_records", "buildings"
  add_foreign_key "census_1930_records", "people"
  add_foreign_key "census_1930_records", "users", column: "created_by_id"
  add_foreign_key "census_1930_records", "users", column: "reviewed_by_id"
  add_foreign_key "people_photos", "people"
  add_foreign_key "people_photos", "photos"
  add_foreign_key "photos", "buildings"
end
