class AddStatusToStrategies < ActiveRecord::Migration[5.2]
  def change
    add_column :strategies, :active, :boolean, default: true
  end
end
