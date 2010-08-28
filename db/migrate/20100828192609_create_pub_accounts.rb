class CreatePubAccounts < ActiveRecord::Migration
  def self.up
    create_table :pub_accounts do |t|
      t.string :account
      t.string :reason

      t.timestamps
    end
  end

  def self.down
    drop_table :pub_accounts
  end
end
