class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :title
      t.integer :user
      t.string :password
      t.text :description
      t.string :cover

      t.timestamps null: false
    end
  end
end
