class RenameLangtitudeToLongtitudeInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :langtitude, :longitude
  end

  def down
    rename_column :users, :longitude, :langtitude
  end
end
