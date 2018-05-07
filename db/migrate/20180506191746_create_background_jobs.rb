class CreateBackgroundJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :background_jobs do |t|
      t.string   "job_name",   limit: 255
      t.string   "job_uid",       limit: 255
      t.integer  "status"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "data",       default: "{}"
    end
  end
end
