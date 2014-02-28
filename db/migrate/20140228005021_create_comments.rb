class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :link, null: false
      t.references :parent_comment
      t.string     :body, null: false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :link_id
    add_index :comments, :parent_comment_id
  end
end
