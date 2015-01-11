class AddDetailsToUserMonthlyView < ActiveRecord::Migration
  def change
    add_column :user_monthly_views, :user_id, :integer
    add_column :user_monthly_views, :website_id, :integer
    add_column :user_monthly_views, :month, :string
    add_column :user_monthly_views, :year, :string
    add_column :user_monthly_views, :views, :integer
  end
end
