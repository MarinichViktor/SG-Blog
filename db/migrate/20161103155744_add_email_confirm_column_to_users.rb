class AddEmailConfirmColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_confirm_status, :boolean, default: false
    add_column :users, :confirm_token, :string
  end
end
