class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :body
      t.string :url, null: false
      t.references :user
      t.timestamps
    end
    add_index :links, :user_id
  end
end
