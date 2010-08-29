class CreateStatsEntries < ActiveRecord::Migration
  def self.up
    create_table :stats_entries do |t|
      t.date :when
      t.integer :total
    end
  end

  def self.down
    drop_table :stats_entries
  end
end
