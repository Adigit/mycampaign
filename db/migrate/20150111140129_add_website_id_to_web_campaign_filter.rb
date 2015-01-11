class AddWebsiteIdToWebCampaignFilter < ActiveRecord::Migration
  def change
    add_column :web_campaign_filters, :website_id, :integer
  end
end
