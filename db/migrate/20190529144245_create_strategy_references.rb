class CreateStrategyReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :strategy_references do |t|
      t.text :built_in

      t.timestamps
    end
  end
end
