class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :code
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
