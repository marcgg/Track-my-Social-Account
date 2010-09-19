task :populate_twitter => :environment do
  puts "POPULATING TWITTER"
  
  threshold = 1000
  req = Curl::Easy.new("http://api.twitter.com/1/statuses/public_timeline.json")
  
  EventMachine.run do
    EventMachine::PeriodicTimer.new(5) do
      req.perform
      results = ActiveSupport::JSON.decode(req.body_str)
      results.each do |result|
        screen_name = result["user"]["screen_name"]
        followers_count = result["user"]["followers_count"].to_i
        puts "Looking to save user #{screen_name}, with #{followers_count} followers"
        if followers_count.to_i > threshold
          if PubAccounts::Twitter.find_by_account(screen_name).nil?
            PubAccounts::Twitter.create! :account => screen_name
          end
        end
      end
    end
  end
  
end