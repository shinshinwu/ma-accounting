# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170322215850) do

  create_table "activity_trackers", force: :cascade do |t|
    t.string   "email",          limit: 255,   null: false
    t.string   "key",            limit: 255
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.text     "parameters",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_trackers", ["email"], name: "index_activity_trackers_on_email", using: :btree
  add_index "activity_trackers", ["key"], name: "index_activity_trackers_on_key", using: :btree
  add_index "activity_trackers", ["recipient_id", "recipient_type"], name: "index_activity_on_recipient_id_and_type", using: :btree
  add_index "activity_trackers", ["trackable_id", "trackable_type"], name: "index_activity_on_trackable_id_and_type", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",                           null: false
    t.string   "encrypted_password",     limit: 255, default: "",                           null: false
    t.string   "first_name",             limit: 255,                                        null: false
    t.string   "last_name",              limit: 255,                                        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "time_zone",              limit: 255, default: "Eastern Time (US & Canada)", null: false
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.date     "start_date",                null: false
    t.date     "end_date"
    t.string   "title",       limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: :cascade do |t|
    t.string   "slug",              limit: 35,  null: false
    t.integer  "sender_id",         limit: 4,   null: false
    t.string   "sender_type",       limit: 10,  null: false
    t.integer  "recipient_id",      limit: 4,   null: false
    t.string   "recipient_type",    limit: 10,  null: false
    t.integer  "course_module_id",  limit: 4
    t.string   "subject",           limit: 100, null: false
    t.datetime "last_contacted_at",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["course_module_id"], name: "index_conversations_on_course_module_id", using: :btree
  add_index "conversations", ["last_contacted_at"], name: "index_conversations_on_last_contacted_at", using: :btree
  add_index "conversations", ["recipient_id", "recipient_type"], name: "index_conversations_on_recipient_id_and_recipient_type", using: :btree
  add_index "conversations", ["sender_id", "sender_type"], name: "index_conversations_on_sender_id_and_sender_type", using: :btree
  add_index "conversations", ["slug"], name: "index_conversations_on_slug", using: :btree

  create_table "course_assignments", force: :cascade do |t|
    t.integer  "course_module_id", limit: 4,     null: false
    t.string   "title",            limit: 255,   null: false
    t.text     "instructions",     limit: 65535, null: false
    t.integer  "sort_order",       limit: 4,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_assignments", ["course_module_id", "sort_order"], name: "index_course_assignments_on_course_module_id_and_sort_order", unique: true, using: :btree

  create_table "course_completions", force: :cascade do |t|
    t.integer  "course_progress_id", limit: 4, null: false
    t.integer  "course_module_id",   limit: 4, null: false
    t.date     "start_date"
    t.date     "due_date"
    t.date     "completion_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_completions", ["course_progress_id", "course_module_id"], name: "index_course_completions_on_progress_and_module", unique: true, using: :btree

  create_table "course_contents", force: :cascade do |t|
    t.integer  "course_module_id", limit: 4,     null: false
    t.text     "description",      limit: 65535
    t.integer  "sort_order",       limit: 4,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_contents", ["course_module_id", "sort_order"], name: "index_course_contents_on_course_module_id_and_sort_order", unique: true, using: :btree
  add_index "course_contents", ["course_module_id"], name: "index_course_contents_on_course_module_id", using: :btree

  create_table "course_modules", force: :cascade do |t|
    t.integer "unit_id",    limit: 4,   null: false
    t.string  "name",       limit: 255, null: false
    t.integer "sort_order", limit: 4,   null: false
  end

  add_index "course_modules", ["name"], name: "index_course_modules_on_name", using: :btree
  add_index "course_modules", ["unit_id", "sort_order"], name: "index_course_modules_on_unit_id_and_sort_order", unique: true, using: :btree

  create_table "course_progresses", force: :cascade do |t|
    t.integer  "user_id",           limit: 4, null: false
    t.integer  "current_module_id", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_progresses", ["user_id"], name: "index_course_progresses_on_user_id", using: :btree

  create_table "course_videos", force: :cascade do |t|
    t.integer  "course_content_id", limit: 4,   null: false
    t.string   "title",             limit: 255, null: false
    t.string   "url",               limit: 255, null: false
    t.integer  "sort_order",        limit: 4,   null: false
    t.integer  "length_minutes",    limit: 4,   null: false
    t.integer  "length_seconds",    limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_videos", ["course_content_id", "sort_order"], name: "index_course_videos_on_course_content_id_and_sort_order", unique: true, using: :btree
  add_index "course_videos", ["title"], name: "index_course_videos_on_title", using: :btree

  create_table "cpas", force: :cascade do |t|
    t.string   "first_name",  limit: 255, null: false
    t.string   "last_name",   limit: 255, null: false
    t.string   "company",     limit: 255
    t.integer  "joined_year", limit: 4
    t.string   "phone",       limit: 255
    t.string   "street",      limit: 255
    t.string   "city",        limit: 255
    t.string   "zipcode",     limit: 255
    t.string   "state",       limit: 255
    t.string   "site",        limit: 255
    t.string   "source",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "cpas", ["city", "state"], name: "index_cpas_on_city_and_state", using: :btree
  add_index "cpas", ["first_name", "last_name"], name: "index_cpas_on_first_name_and_last_name", using: :btree
  add_index "cpas", ["joined_year"], name: "index_cpas_on_joined_year", using: :btree
  add_index "cpas", ["phone"], name: "index_cpas_on_phone", using: :btree
  add_index "cpas", ["source"], name: "index_cpas_on_source", using: :btree
  add_index "cpas", ["zipcode"], name: "index_cpas_on_zipcode", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "document_files", force: :cascade do |t|
    t.string   "documentable_type", limit: 255, null: false
    t.integer  "documentable_id",   limit: 4,   null: false
    t.string   "doc_file_name",     limit: 255
    t.string   "doc_content_type",  limit: 255
    t.integer  "doc_file_size",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "document_files", ["documentable_type", "documentable_id"], name: "index_document_files_on_documentable_type_and_id", using: :btree

  create_table "email_settings", force: :cascade do |t|
    t.string   "email",           limit: 255, null: false
    t.boolean  "subscribed"
    t.datetime "unsubscribed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_settings", ["email"], name: "index_email_settings_on_email", using: :btree
  add_index "email_settings", ["subscribed"], name: "index_email_settings_on_subscribed", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "status",          limit: 255,                null: false
    t.integer  "user_id",         limit: 4
    t.integer  "product_id",      limit: 4
    t.integer  "promotion_id",    limit: 4
    t.string   "code",            limit: 255,                null: false
    t.date     "billing_date",                               null: false
    t.decimal  "total_amount",                precision: 10
    t.decimal  "discount_amount",             precision: 10
    t.string   "transaction_id",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["code"], name: "index_invoices_on_code", using: :btree
  add_index "invoices", ["product_id"], name: "index_invoices_on_product_id", using: :btree
  add_index "invoices", ["promotion_id"], name: "index_invoices_on_promotion_id", using: :btree
  add_index "invoices", ["status"], name: "index_invoices_on_status", using: :btree
  add_index "invoices", ["user_id", "product_id"], name: "index_invoices_on_user_id_and_product_id", unique: true, using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "testing_group", limit: 4
    t.string   "first_name",    limit: 255, null: false
    t.string   "last_name",     limit: 255, null: false
    t.string   "designation",   limit: 255
    t.string   "company",       limit: 255
    t.integer  "joined_year",   limit: 4
    t.string   "email",         limit: 255
    t.string   "phone",         limit: 255
    t.string   "city",          limit: 255
    t.string   "zipcode",       limit: 255
    t.string   "state",         limit: 255
    t.string   "source",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "members", ["city", "state"], name: "index_members_on_city_and_state", using: :btree
  add_index "members", ["email"], name: "index_members_on_email", using: :btree
  add_index "members", ["first_name", "last_name"], name: "index_members_on_first_name_and_last_name", using: :btree
  add_index "members", ["joined_year"], name: "index_members_on_joined_year", using: :btree
  add_index "members", ["phone"], name: "index_members_on_phone", using: :btree
  add_index "members", ["source"], name: "index_members_on_source", using: :btree
  add_index "members", ["testing_group"], name: "index_members_on_testing_group", using: :btree
  add_index "members", ["zipcode"], name: "index_members_on_zipcode", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id", limit: 4
    t.integer  "sender_id",       limit: 4,                     null: false
    t.string   "sender_type",     limit: 10,                    null: false
    t.text     "body",            limit: 65535,                 null: false
    t.boolean  "read",                          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id", "sender_id", "sender_type"], name: "index_messages_on_sender_id_and_type", using: :btree
  add_index "messages", ["created_at"], name: "index_messages_on_created_at", using: :btree
  add_index "messages", ["read"], name: "index_messages_on_read", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "code",        limit: 255, null: false
    t.string   "description", limit: 255, null: false
    t.integer  "price",       limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["code"], name: "index_products_on_code", using: :btree

  create_table "products_promotions", id: false, force: :cascade do |t|
    t.integer "product_id",   limit: 4
    t.integer "promotion_id", limit: 4
  end

  add_index "products_promotions", ["product_id", "promotion_id"], name: "index_products_promotions_on_product_id_and_promotion_id", unique: true, using: :btree
  add_index "products_promotions", ["product_id"], name: "index_products_promotions_on_product_id", using: :btree
  add_index "products_promotions", ["promotion_id"], name: "index_products_promotions_on_promotion_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "promotion_type",      limit: 255, null: false
    t.string   "frequency",           limit: 255, null: false
    t.integer  "amount_discount",     limit: 4,   null: false
    t.integer  "percentage_discount", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promotions", ["frequency"], name: "index_promotions_on_frequency", using: :btree
  add_index "promotions", ["promotion_type"], name: "index_promotions_on_promotion_type", using: :btree

  create_table "quizz_answers", force: :cascade do |t|
    t.integer  "quizz_question_id", limit: 4,   null: false
    t.string   "description",       limit: 255, null: false
    t.boolean  "is_correct",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizz_answers", ["quizz_question_id"], name: "index_quizz_answers_on_quizz_question_id", using: :btree

  create_table "quizz_attempts", force: :cascade do |t|
    t.integer  "user_id",            limit: 4,     null: false
    t.integer  "quizz_id",           limit: 4,     null: false
    t.text     "correctly_answered", limit: 65535, null: false
    t.boolean  "passed",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizz_attempts", ["quizz_id", "user_id"], name: "index_quizz_attempts_on_quizz_id_and_user_id", using: :btree

  create_table "quizz_questions", force: :cascade do |t|
    t.integer  "quizz_id",    limit: 4,   null: false
    t.integer  "sort_order",  limit: 4,   null: false
    t.string   "description", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizz_questions", ["quizz_id", "sort_order"], name: "index_quizz_questions_on_quizz_id_and_sort_order", unique: true, using: :btree

  create_table "quizzes", force: :cascade do |t|
    t.integer "course_module_id",   limit: 4,                null: false
    t.string  "title",              limit: 255,              null: false
    t.integer "passing_percentage", limit: 4,   default: 90, null: false
  end

  add_index "quizzes", ["course_module_id"], name: "index_quizzes_on_course_module_id", using: :btree

  create_table "static_images", force: :cascade do |t|
    t.string   "imageable_type",   limit: 255, null: false
    t.integer  "imageable_id",     limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_file_name",    limit: 255
    t.string   "img_content_type", limit: 255
    t.integer  "img_file_size",    limit: 4
    t.datetime "img_updated_at"
  end

  add_index "static_images", ["imageable_type", "imageable_id"], name: "index_static_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "supporting_materials", force: :cascade do |t|
    t.integer  "course_module_id", limit: 4,     null: false
    t.string   "title",            limit: 255,   null: false
    t.text     "description",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporting_materials", ["course_module_id"], name: "index_supporting_materials_on_course_module_id", using: :btree

  create_table "suppression_lists", force: :cascade do |t|
    t.string   "email",      limit: 255, null: false
    t.string   "source",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suppression_lists", ["email"], name: "index_suppression_lists_on_email", using: :btree
  add_index "suppression_lists", ["source"], name: "index_suppression_lists_on_source", using: :btree

  create_table "units", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.integer "sort_order", limit: 4,   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "access_token",           limit: 255,                                        null: false
    t.integer  "testing_group",          limit: 4
    t.string   "email",                  limit: 255,                                        null: false
    t.string   "encrypted_password",     limit: 255,                                        null: false
    t.boolean  "temprorary_password",                default: false,                        null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "zipcode",                limit: 10
    t.string   "stripe_customer_id",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "time_zone",              limit: 255, default: "Pacific Time (US & Canada)", null: false
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["testing_group"], name: "index_users_on_testing_group", using: :btree

  create_table "zip_code_details", id: false, force: :cascade do |t|
    t.string  "zip_code",             limit: 255
    t.string  "zip_code_type",        limit: 255
    t.string  "primary_city",         limit: 255
    t.string  "primary_city_slug",    limit: 255,                                  null: false
    t.text    "acceptable_cities",    limit: 4294967295
    t.text    "unacceptable_cities",  limit: 4294967295
    t.string  "state",                limit: 255
    t.string  "state_full_name",      limit: 40
    t.string  "county",               limit: 255
    t.string  "timezone",             limit: 255
    t.string  "area_codes",           limit: 255
    t.decimal "lat",                                     precision: 15, scale: 10
    t.decimal "lng",                                     precision: 15, scale: 10
    t.string  "world_region",         limit: 255
    t.string  "country",              limit: 255
    t.integer "decommissioned",       limit: 4
    t.integer "estimated_population", limit: 4
    t.string  "notes",                limit: 255
  end

  add_index "zip_code_details", ["primary_city_slug"], name: "index_zip_code_details_on_primary_city_slug", using: :btree
  add_index "zip_code_details", ["state"], name: "index_zip_code_details_on_state", using: :btree
  add_index "zip_code_details", ["zip_code"], name: "index_zip_code_details_on_zip_code", unique: true, using: :btree

  create_table "zip_codes", force: :cascade do |t|
    t.string  "zip_code",          limit: 255,                         null: false
    t.string  "usps_type",         limit: 10
    t.integer "population",        limit: 4
    t.integer "avg_income",        limit: 4
    t.integer "avg_age",           limit: 4
    t.decimal "percent_with_kids",             precision: 3, scale: 2
    t.integer "avg_home_value",    limit: 4
  end

  add_index "zip_codes", ["zip_code"], name: "index_zip_codes_on_zip_code", unique: true, using: :btree

end
