class CreateUserAccountInfo < ActiveRecord::Migration
  def change
    create_table(:user_account_infos) do |t|
      t.references :user

      t.string :first_name, :null => false
      t.string :last_name,  :null => false

      t.timestamps
    end

    add_index :user_account_infos, :user_id, unique: true
  end
end
