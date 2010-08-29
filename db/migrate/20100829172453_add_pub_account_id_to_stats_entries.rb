class AddPubAccountIdToStatsEntries < ActiveRecord::Migration
  def self.up
    add_column :stats_entries, :pub_account_id, :integer
  end

  def self.down
    remove_column :stats_entries, :pub_account_id
  end
end
