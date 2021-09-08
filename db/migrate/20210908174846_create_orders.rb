class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
      t.index [:user_id, :course_id], unique: true
    end
  end
end
