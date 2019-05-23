class RenameTokenToGoogleId < ActiveRecord::Migration[5.2]
  def change
    rename_column :students, :token, :google_id
  end
end
