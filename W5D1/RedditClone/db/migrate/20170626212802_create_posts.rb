class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :content
      t.integer :author_id
      t.integer :sub_id

      t.timestamps
    end

    add_index :posts, :author_id
    add_index :posts, :sub_id
  end

end
