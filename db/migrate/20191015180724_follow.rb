class Follow < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :followee, index: true
      t.timestamps
    end
    add_foreign_key :follows, :users, column: :followee_id
  end
end
