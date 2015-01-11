class CreateMobileAppUuidMaps < ActiveRecord::Migration
  def change
    create_table :mobile_app_uuid_maps do |t|
      t.integer :mobile_app_id
      t.integer :mobile_uuid_id
      t.timestamp :last_seen_at

      t.timestamps
    end
  end
end
