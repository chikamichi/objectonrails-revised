class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :image_url
      t.datetime :pubdate
      t.timestamps
    end
  end
end
