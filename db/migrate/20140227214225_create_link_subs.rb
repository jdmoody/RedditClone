class CreateLinkSubs < ActiveRecord::Migration
  def change
    create_table :link_subs do |t|
      t.references :sub
      t.references :link

      t.timestamps
    end
    add_index :link_subs, :sub_id
    add_index :link_subs, :link_id
  end
end
