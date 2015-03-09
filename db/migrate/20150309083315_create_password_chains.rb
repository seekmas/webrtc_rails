class CreatePasswordChains < ActiveRecord::Migration
  def change
    create_table :password_chains do |t|
      t.integer :user_id
      t.integer :home_id

      t.timestamps null: false
    end
  end
end
