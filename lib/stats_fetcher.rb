module StatsFetcher
  extend self
  
  def run
    puts "Running Stats Fetcher at #{Time.now}"
    stats_on_facebook_pages
  end
  
  ########################################################
  
  def stats_on_facebook_pages
    sess = Patron::Session.new
    sess.base_url = "https://graph.facebook.com/"
    
    all_pages = PubAccounts::FacebookPage.all
    all_pages.each do |page|
      begin
        puts "Fetching for #{page.account}"
        response = sess.get page.account
        count = ActiveSupport::JSON.decode(response.body)["fan_count"].to_i
        puts "\t=> count = #{count}"
        page.stats_entries << StatsEntry.new(:total => count, :when => Time.now)
      rescue Exception => e
        logger.info "Error (#{e.class})\n#{e.backtrace.to_yaml}"
      end
    end
  end
  
  ########################################################
end