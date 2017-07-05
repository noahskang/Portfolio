class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.timestamps null: false
      t.string :session_token, null: false
    end

    add_index :users, :session_token, name: "index_users_on_session_token", unique: true
    add_index :users, :user_name, name: "index_users_on_username", unique: true
  end
end
