class ChangeUserEmailNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:users, :email, false)
  end
end