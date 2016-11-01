class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :profile_img
      t.string :password_diggest

      t.timestamps null: false
    end
  end
end
