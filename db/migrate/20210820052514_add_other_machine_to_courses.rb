class AddOtherMachineToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :other_machine, :string
  end
end
