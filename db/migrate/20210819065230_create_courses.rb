class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.integer :category_id, null: false
      t.text :text_1, null: false
      t.text :text_2
      t.text :text_3
      t.text :text_4
      t.integer :hour_id, null: false
      t.integer :machine_id, null: false
      t.string :other_machine
      t.integer :time_zone_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
