class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :openstax_connect_user_id
      t.boolean :is_administrator
      t.boolean :is_registered

      t.timestamps
    end

    add_index :users, :openstax_connect_user_id, :unique => true
  end
end
