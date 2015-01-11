class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.string :email
      t.integer :user_id
      t.string :error_message

      t.timestamps
    end
  end
end
