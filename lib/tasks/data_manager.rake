task :data_manager => :environment do
  puts "DISPLAYING DATA"
  puts "\tPub Account"
  PubAccount.all.each do |pub_account|
    puts "\t\t#{pub_account.id} - #{pub_account.account.inspect}"
    pub_account.stats_entries.each do |stats_entry|
      puts "\t\t\t#{stats_entry.total.inspect} - #{stats_entry.when.inspect}"
    end
  end
end