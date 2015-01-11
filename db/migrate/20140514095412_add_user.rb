class AddUser < ActiveRecord::Migration
  def change
        add_column :users, :bounce_email, :integer, :default => 0
  end
end
