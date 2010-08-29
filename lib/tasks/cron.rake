task :cron => :environment do
  puts "Running Cron"
  StatsFetcher.run
end