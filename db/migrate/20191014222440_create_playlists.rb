class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :owner
      t.string :image
      t.text :description
      t.boolean :collaborative
      t.boolean :public
      t.integer :followers
      t.integer :length
      t.timestamps

      t.belongs_to :user, required: false
    end
  end
end
