class AddTypeToPubAccounts < ActiveRecord::Migration
  def self.up
    add_column :pub_accounts, :type, :string
  end

  def self.down
    remove_column :pub_accounts, :type
  end
end
