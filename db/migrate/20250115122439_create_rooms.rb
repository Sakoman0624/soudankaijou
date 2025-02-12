class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :title
      t.text :body
      t.integer :public_flag
      t.timestamps
    end
  end
end
