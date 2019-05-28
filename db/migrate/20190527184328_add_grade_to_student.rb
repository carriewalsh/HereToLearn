class AddGradeToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :grade_level, :integer

  end
end
