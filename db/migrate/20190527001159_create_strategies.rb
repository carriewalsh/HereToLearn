class CreateStrategies < ActiveRecord::Migration[5.2]
  def change
    create_table :strategies do |t|
      t.text :strategy
      t.references :teacher, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
