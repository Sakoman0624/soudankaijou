class AddTagIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :tag_id, :integer
  end
end
