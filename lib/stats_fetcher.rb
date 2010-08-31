module StatsFetcher
  extend self
  
  def run
    puts "Running Stats Fetcher at #{Time.now}"
    begin
      stats_on_facebook_pages
    rescue Exception => e
      puts "ERROR #{e.class} on Facebook Pages Fetching"
    end
    begin
      stats_on_twitter_accounts
    rescue Exception => e
      puts "ERROR #{e.class} on Twitter Accounts Fetching"
    end
    
  end
  
  ########################################################
  
  def stats_on_facebook_pages
    puts "============ FACEBOOK PAGES ============ "
    sess = Patron::Session.new
    sess.base_url = "https://graph.facebook.com/"
    sess.timeout = 20
    
    all_pages = PubAccounts::FacebookPage.all
    all_pages.each do |page|
      begin
        puts "Fetching for #{page.account}"
        response = sess.get page.account
        count = ActiveSupport::JSON.decode(response.body)["fan_count"].to_i
        puts "\t=> Count = #{count}"
        StatsEntry.create!(:total => count, :when => Time.now, :pub_account_id => page.id)
      rescue Exception => e
        puts "Error (#{e.class})\n#{e.backtrace.to_yaml}"
      end
    end
  end
  
  ########################################################
  
  def stats_on_twitter_accounts
    #http://api.twitter.com/1/users/show.json?screen_name=marcgg
    puts "============ TWITTER ACCOUNTS ============ "
    
    all_twitter = PubAccounts::Twitter.all
    all_twitter.each do |twitter|
      begin
        puts "Fetching for #{twitter.account}"
        req = Curl::Easy.new("http://api.twitter.com/1/users/show.json?screen_name=#{twitter.account}")
        req.perform
        count = ActiveSupport::JSON.decode(req.body_str)["followers_count"]
        puts "\t=> Count = #{count}"
        StatsEntry.create!(:total => count, :when => Time.now, :pub_account_id => twitter.id)
      rescue Exception => e
        puts "Error (#{e.class})\n#{e.backtrace.to_yaml}"
      end
    end
    
    
  end
  
  ########################################################
end