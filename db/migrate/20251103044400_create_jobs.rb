class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string  :title, null: false
      t.integer :status, default: 0, null: false
      t.datetime :published_date
      t.integer :salary_from
      t.integer :salary_to
      t.string  :share_link
      t.references :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :jobs, :share_link, unique: true
  end
end
