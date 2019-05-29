class AddEnumToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :role, :integer
  end
end
