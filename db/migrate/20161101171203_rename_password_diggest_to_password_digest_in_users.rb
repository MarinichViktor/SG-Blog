class RenamePasswordDiggestToPasswordDigestInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :password_diggest, :password_digest
  end

  def down
    rename_column :users, :password_digest, :password_diggest
  end
end
