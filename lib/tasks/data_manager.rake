task :display_data => :environment do
  puts "DISPLAYING DATA"
  puts "\tPub Account"
  PubAccount.all.each do |pub_account|
    puts "\t\t#{pub_account.id} - #{pub_account.account.inspect}"
    pub_account.stats_entries.each do |stats_entry|
      puts "\t\t\t#{stats_entry.total.inspect} - #{stats_entry.when.inspect}"
    end
  end
end

task :fix_nil => :environment do
  # At the beginning of development, some data got corrupted, this is a way to fix this
  puts "\tFIXING PUB ACCOUNTS"
  PubAccount.all.each do |pub_account|
    puts "\t\t#{pub_account.id} - #{pub_account.account.inspect}"
    pub_account.stats_entries.each_with_index do |stats_entry,i|
      puts "\t\t\t#{stats_entry.total.inspect} - #{stats_entry.when.inspect}"
      if i == 0 and stats_entry.total.nil?
        puts "\t\t\t\tDestroying nil"
        stats_entry.destroy
      end
      if i > 0 and stats_entry.total.nil? and i != (pub_account.stats_entries.size - 1)
        new_value = (pub_account.stats_entries[i-1].total + pub_account.stats_entries[i+1].total ) /2
        puts "\t\t\t\tSetting nil #{new_value}"
        stats_entry.update_attributes! :total => new_value
      end
    end
  end
end