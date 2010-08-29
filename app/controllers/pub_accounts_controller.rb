class PubAccountsController < ApplicationController
  def create
    klass = params[:type].constantize
    @pub_account = PubAccount.find_by_account(params[:pub_account][:account])
    if @pub_account.nil?
      @pub_account = klass.create!(params[:pub_account]) 
      flash[:notice] = "Ok, got it. We'll start tracking this page from now on!"
    else
      flash[:notice] = "It looks like someone already asked us to track this page, so here is what we fetched so far!"
    end
    redirect_to pub_account_path(@pub_account)
  end
  
  def show
    @pub_account = PubAccount.find(params[:id])
  end
  
  def csv
    @pub_account = PubAccount.find(params[:id])
    csv_string = FasterCSV.generate do |csv|
      csv << ["Data for account #{@pub_account.account} (#{@pub_account.class})"]
      csv << ["date", "count"]
      @pub_account.stats_entries.each do |se|
        csv << [se.when, se.total]
      end
    end

    # send it to the browsah
    send_data(csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=export-#{@pub_account.id}-#{@pub_account.account}.csv")
  end
end
