class AddPublicToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :public, :boolean, default: true, null: false
  end
end
