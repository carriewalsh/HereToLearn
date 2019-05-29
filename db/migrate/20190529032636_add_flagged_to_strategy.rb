class AddFlaggedToStrategy < ActiveRecord::Migration[5.2]
  def change
    add_column :strategies, :flagged, :boolean, default: false
  end
end
