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

ActiveRecord::Schema.define(version: 2019_05_27_184328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.integer "attendance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_attendances_on_course_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "codes", force: :cascade do |t|
    t.string "code"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_codes_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "period"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "strategies", force: :cascade do |t|
    t.text "strategy"
    t.bigint "teacher_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_strategies_on_student_id"
    t.index ["teacher_id"], name: "index_strategies_on_teacher_id"
  end

  create_table "student_courses", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.index ["course_id"], name: "index_student_courses_on_course_id"
    t.index ["student_id"], name: "index_student_courses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "student_id"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grade_level"
  end

  create_table "teacher_courses", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "course_id"
    t.index ["course_id"], name: "index_teacher_courses_on_course_id"
    t.index ["teacher_id"], name: "index_teacher_courses_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
  end

  add_foreign_key "attendances", "courses"
  add_foreign_key "attendances", "students"
  add_foreign_key "codes", "courses"
  add_foreign_key "strategies", "students"
  add_foreign_key "strategies", "teachers"
  add_foreign_key "student_courses", "courses"
  add_foreign_key "student_courses", "students"
  add_foreign_key "teacher_courses", "courses"
  add_foreign_key "teacher_courses", "teachers"
end
